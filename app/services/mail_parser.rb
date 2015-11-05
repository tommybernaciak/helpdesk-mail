require 'gmail'
class MailParser

  def self.parse_emails(user, pass, url)
    gmail = Gmail.new(user, pass)
    puts gmail.inbox.count(:unread)
    puts gmail.inbox.emails(:unread)
    puts gmail.inbox.emails(:unread).first
    gmail.inbox.emails(:unread).each do |email|
      send(email, url)
      email.mark(:read)
    end
    gmail.logout
  end

  def send(data, url)
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    #http.use_ssl = true
    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json
    http.request(request)
  end

end
