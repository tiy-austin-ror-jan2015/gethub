require 'open-uri'
require 'JSON'

class Context
  USERNAME    = (raise 'No name given. Put your github username on line 5 of lib/context.rb') #'YOUR_GITHUB_USERNAME_HERE'
  PROFILE_URL = "https://api.github.com/users/#{USERNAME}"
  REPOS_URL   = "https://api.github.com/users/#{USERNAME}/repos?sort=updated"

  def initialize(data_src = :static)
    case data_src
    when :static
      begin
        @profile_data = JSON.parse(open('profile.json'))
        @repos_data   = JSON.parse(open('repos.json'))
      rescue StandardError => error
        if error.message.scan(/[a-z]+\.json/).first == 'profile.json'
          STDERR.puts "No profile data given. go to #{PROFILE_URL} and paste the response here"
        else
          STDERR.puts "No repos data given. go to #{REPOS_URL} and paste the response here"
        end
      end
    when :live
      profile_response = open(PROFILE_URL).read
      repos_response   = open(REPOS_URL).read
      @profile_data = JSON.parse(profile_response)
      @repos_data   = JSON.parse(repos_response)
    else
      raise ArgumentError, "#{data_src} is not a valid data_src"
    end
    @name = @profile_data['name']
  end

  def get_binding
    binding
  end

end
