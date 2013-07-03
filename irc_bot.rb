require 'cinch'
require 'cleverbot-api'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.nick = "aLiZa"
    c.channels = ["#hackny"]
  end

  on :connect do |m|
      ALIZA = CleverBot.new
      QUOTES = File.open('quotes.txt').readlines
  end

  on :message, /encourage/ do |m|
      m.reply "#{m.user.nick}: " + QUOTES.sample(1).first
  end

  on :message, /.*/ do |m|
      if m.message.match(/^#{m.bot.nick}:/)
          msg = m.message.gsub(/^#{m.bot.nick}:/, '')
          response = ALIZA.think(msg)
          m.reply "#{m.user.nick}: " + response.gsub(/cleverbot/i, m.bot.nick) unless response.nil?
      end
  end
end

bot.start
