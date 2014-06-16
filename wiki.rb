require_relative 'model.rb'

class Controller
  def initialize
    user_interface
  end

  private

  def user_interface
    user_query = Topic.new(get_topic)
    return if user_query.topic.empty?
    user_query.get_summary
    until user_query.topic.empty?
      View.output(user_query.summary)
      user_query = Topic.new(get_topic)
      return if user_query.topic.empty?
      user_query.get_summary
    end
  end

  def get_topic
    puts "What wikipedia summary would you like to see? Press return to exit."
    topic = gets.chomp
  end
end

class View
  def self.output(user_query)
    if user_query.nil? || user_query.include?("This is a redirect") || user_query.empty?
      puts "Error: Wikipedia entry not found. Please check your spelling."
    elsif user_query.include?("refers to:") || user_query.include?("refer to:")
      puts "Error: Disambiguation page retreived."
    else
      puts user_query
    end
  end
end

controller = Controller.new
