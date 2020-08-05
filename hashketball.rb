require 'pry'

# Write your code below game_hash
def game_hash
  {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: [
        {
          player_name: "Alan Anderson",
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        {
          player_name: "Reggie Evans",
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7
        },
        {
          player_name: "Brook Lopez",
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15
        },
        {
          player_name: "Mason Plumlee",
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 11,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5
        },
        {
          player_name: "Jason Terry",
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1
        }
      ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [
        {
          player_name: "Jeff Adrien",
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2
        },
        {
          player_name: "Bismack Biyombo",
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10
        },
        {
          player_name: "DeSagna Diop",
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5
        },
        {
          player_name: "Ben Gordon",
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0
        },
        {
          player_name: "Kemba Walker",
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 7,
          blocks: 5,
          slam_dunks: 12
        }
      ]
    }
  }
end

# Write code here

def num_points_scored(name)
  player = player_stats(name)
  player ? player[:points] : nil
end

def shoe_size(name)
  player = player_stats(name)
  player ? player[:shoe] : nil
end

def team_colors(team)
  game_hash.find {|home_away, team_info| team_info[:team_name] == team}[1][:colors]
end

def team_names
  game_hash.collect {|home_away, team_info| team_info[:team_name]}
end

def player_numbers(team)
  team_hash = game_hash.find do |home_away, team_info|
    team_info[:team_name] == team
  end
  team_hash[1][:players].collect do |player_hash|
    player_hash[:number]
  end
end

def player_stats(name)
  player_hash = nil
  game_hash.each do |home_away, team_info|
    player_hash = team_info[:players].find do |player|
      player[:player_name] == name
    end
    return player_hash if player_hash
  end
end

def big_shoe_rebounds
  game = game_hash
  all_players = game[:home][:players].concat(game[:away][:players])
  all_players.max_by {|player_info| player_info[:shoe]}[:rebounds]
end

def most_points_scored
  game = game_hash
  all_players = game[:home][:players].concat(game[:away][:players])
  most_points = all_players.max_by do |player_info|
    player_info[:points]
  end
  most_points[:player_name]
end

def winning_team
  final_score = {}
  game_hash.each do |home_away, team_info|
    final_score[team_info[:team_name]] = team_info[:players].sum {|player| player[:points]}
  end
  final_score.max_by{|team, score| score}[0]
end

def long_name_steals_a_ton?
  game = game_hash
  all_players = game[:home][:players].concat(game[:away][:players])
  all_players.max_by {|player| player[:steals]} == all_players.max_by {|player| player[:player_name].length}
end
