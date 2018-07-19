require "discordcr"
require "./suggestionbot/*"


class Config
    JSON.mapping(
        regexes: {type: Hash(String,String)},
        command_regex: String,
        token: String,
        client_id: String
    )
end

settings_filename = "settings.json"
abort "Missing settings.json", 1 if !File.file? "settings.json"
settings = Config.from_json(File.read settings_filename)

client = Discord::Client.new(token: settings.token, 
        client_id: settings.client_id.to_u64)

client.on_message_create do |payload|
    # If this message was sent by this bot, ignore.
    next if payload.author.id == client.get_current_user.id

    if /#{settings.command_regex}/.match(payload.content).try do |result|
            # Parse command	to change a regex
            if result[2].size == 0
                # If empty suggestion, delete that regex entry
                settings.regexes.delete(result[1])
            else
                # Add regex
                settings.regexes[result[1]] = result[2]
            end

            File.open settings_filename, "w" do |file|
                settings.to_json(file)
            end
        end
    else
        # Send a suggestion 
        msg = payload.content
        matched = false
        settings.regexes.each do |rgx|
            matched = true if /#{rgx[0]}/i.match(payload.content)
            msg = msg.gsub(/#{rgx[0]}/i, '*' + rgx[1] + '*')
            #end
        end
        if matched
            #msg = "Did you mean: #{msg}"
            msg = "#{payload.author.username}: #{msg}"
            client.create_message(payload.channel_id.to_u64, msg)
        end
    end
end

client.run

