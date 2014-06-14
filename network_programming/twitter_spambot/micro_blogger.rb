require 'jumpstart_auth'
require 'bitly'

class MicroBlogger
  attr_reader :client 

  def initialize 
    puts 'Initializing'
    @client = JumpstartAuth.twitter
  end

  def tweet(message)
    if message.length > 140
      puts "Message length greater than 140 characters. Could not tweet."
    else
      @client.update(message)
    end
  end

  def dm(target, message)
    followers = @client.followers.map { |follower| follower.screen_name }
    if followers.include? target 
      if message.length == 0
        puts "You didn't enter a message fool!"
      else
        msg = "d #{target} #{message}"
        tweet msg
      end
    else 
      puts "Bro, you can't do that. #{target} is not following you!"
    end
  end

  def followers_list
    @client.followers.map { |follower| follower.screen_name }
  end

  def spam_my_followers(message)
    followers_list.each { |follower| dm(follower, message) }
  end

  def everyones_last_tweet
    friends = @client.friends.sort { |x,y| x.screen_name.downcase <=> y.screen_name.downcase }
    friends.each do |friend|
      last_tweet = friend.status.text
      timestamp = friend.status.created_at
      time = timestamp.strftime("%A, %b %d")
      puts "#{friend.screen_name} said: #{last_tweet} on #{time}"
    end
  end

  def shorten(original_url)
    if original_url
      bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
      Bitly.use_api_version_3
      bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
      return bitly.shorten(original_url).short_url
    else 
      puts "You need to give a URL..."
    end
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter input: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1],parts[2..-1].join(" "))
        when 'fl' then puts followers_list
        when 'spam' then spam_my_followers(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[1])
        when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end
end

blogger = MicroBlogger.new
blogger.run 

