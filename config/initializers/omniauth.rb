Rails.application.config.middleware.use OmniAuth::Builder do
  provider :githubteammember, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "read:org", teams: { "team_member?" => ENV["GITHUB_TEAM_ID"] }
end
