# encoding: utf-8
require 'project1/project1'
require 'set'

sC = "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉ".chars.to_a
sV = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣ".chars.to_a
sO = "ㅗ".chars.to_a
sU = "ㅜ".chars.to_a
sA = "ㅡ".chars.to_a
sI = "ㅏㅐㅑㅒㅓㅔㅕㅖㅛㅠㅣ".chars.to_a
sK = "ㄱㅂ".chars.to_a
sN = "ㄴ".chars.to_a
sR = "ㄹ".chars.to_a
sL = "ㄷㅁㅅㅇㅈㅊㅋㅌㅍㅎㄲㅆ".chars.to_a
sKL = "ㅅ".chars.to_a
sNL = "ㅈㅎ".chars.to_a
sRL = "ㄱㅁㅂㅅㅌㅍㅎ".chars.to_a

states = ["S", "V", "O", "U", "A", "I", "K", "N", "R", "L"]
symbols = "ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣ".chars.to_a
transition = Hash.new
outputTransition = Hash.new
states.each do |state|
  transition[state] = Hash.new
  outputTransition[state] = Hash.new
end
sC.each do |symbol|
  transition["S"][symbol] = "V"
  outputTransition["S"][symbol] = lambda {|state, symbol|
    $buffer["first"] = symbol
  }
end
sC.each do |symbol|
  transition["V"][symbol] = "V"
  outputTransition["V"][symbol] = lambda {|state, symbol|
    if $buffer["first"] != nil
      $result += elementsToChar($buffer)
      $buffer.clear
    end
    $buffer["first"] = symbol
  }
end
sC.each do |symbol|
  transition["L"][symbol] = "V"
  outputTransition["L"][symbol] = lambda {|state, symbol|
    $buffer["last"] = case $buffer["last"]
                      when nil then $buffer["next"]
                      when "ㄱ" then "ㄳ"
                      when "ㅂ" then "ㅄ"
                      when "ㄴ"
                        case $buffer["next"]
                        when "ㅈ" then "ㄵ"
                        when "ㅎ" then "ㄶ"
                        end
                      when "ㄹ"
                        case $buffer["next"]
                        when "ㄱ" then "ㄺ"
                        when "ㅁ" then "ㄻ"
                        when "ㅂ" then "ㄼ"
                        when "ㅅ" then "ㄽ"
                        when "ㅌ" then "ㄾ"
                        when "ㅍ" then "ㄿ"
                        when "ㅎ" then "ㅀ"
                        end
                      end
    $result += elementsToChar($buffer)
    $buffer.clear
    $buffer["first"] = symbol
  }
end
[[sO, "O"], [sU, "U"], [sA, "A"], [sI, "I"]].each do |pair|
  pair[0].each do |symbol|
    ["V", "K", "N", "R", "L"].each do |state|
      transition[state][symbol] = pair[1]
    end
    outputTransition["V"][symbol] = lambda {|state, symbol|
      $buffer["middle"] = symbol
    }
    ["K", "N", "R"].each do |state|
      outputTransition[state][symbol] = lambda {|state, symbol|
        $result += elementsToChar($buffer)
        tmp = $buffer["next"]
        $buffer.clear
        $buffer["first"] = tmp
        $buffer["middle"] = symbol
      }
    end
    outputTransition["L"][symbol] = lambda {|state, symbol|
      $result += elementsToChar($buffer)
      tmp = $buffer["next"]
      $buffer.clear
      $buffer["first"] = tmp
      $buffer["middle"] = symbol
    }
  end
end
["ㅏ", "ㅐ", "ㅣ"].each do |symbol| # ㅘ, ㅙ, ㅚ
  transition["O"][symbol] = "I"
  outputTransition["O"][symbol] = lambda {|state, symbol|
    $buffer["middle"] = case symbol
                        when "ㅏ" then "ㅘ"
                        when "ㅐ" then "ㅙ"
                        when "ㅣ" then "ㅚ"
                        end
  }
end
["ㅓ", "ㅔ", "ㅣ"].each do |symbol| # ㅝ, ㅞ, ㅟ
  transition["U"][symbol] = "I"
  outputTransition["U"][symbol] = lambda {|state, symbol|
    $buffer["middle"] = case symbol
                        when "ㅓ" then "ㅝ"
                        when "ㅔ" then "ㅞ"
                        when "ㅣ" then "ㅟ"
                        end
  }
end
transition["A"]["ㅣ"] = "I" # ㅢ
outputTransition["A"]["ㅣ"] = lambda {|state, symbol|
  $buffer["middle"] = "ㅢ"
}
[[sK, "K"], [sN, "N"], [sR, "R"], [sL, "L"]].each do |pair|
  pair[0].each do |symbol|
    ["O", "U", "A", "I"].each do |state|
      transition[state][symbol] = pair[1]
      outputTransition[state][symbol] = lambda {|state, symbol|
        $buffer["next"] = symbol
      }
    end
  end
end
(sC - sK - sN - sR - sL).each do |symbol|
  ["O", "U", "A", "I"].each do |state|
    transition[state][symbol] = "V"
    outputTransition[state][symbol] = lambda {|state, symbol|
      $result += elementsToChar($buffer)
      $buffer.clear
      $buffer["first"] = symbol
    }
  end
end
sKL.each do |symbol|
  transition["K"][symbol] = "L"
  outputTransition["K"][symbol] = lambda {|state, symbol|
    $buffer["last"] = $buffer["next"]
    $buffer["next"] = symbol
  }
end
["ㅈ", "ㅎ"].each do |symbol|
  transition["N"][symbol] = "L"
  outputTransition["N"][symbol] = lambda {|state, symbol|
    $buffer["last"] = $buffer["next"]
    $buffer["next"] = symbol
  }
end
["ㄱ", "ㅁ", "ㅂ", "ㅅ", "ㅌ", "ㅍ", "ㅎ"].each do |symbol|
  transition["R"][symbol] = "L"
  outputTransition["R"][symbol] = lambda {|state, symbol|
    $buffer["last"] = $buffer["next"]
    $buffer["next"] = symbol
  }
end
[[sC - sKL, "K"], [sC - sNL, "N"], [sC - sRL, "R"]].each do |pair|
  pair[0].each do |symbol|
    transition[pair[1]][symbol] = "V"
    outputTransition[pair[1]][symbol] = lambda {|state, symbol|
      $buffer["last"] = $buffer["next"]
      $result += elementsToChar($buffer)
      $buffer.clear
      $buffer["first"] = symbol
    }
  end
end
outputs = outputTransition.values.map(&:values).reduce(:+)
stateTransitionFunction = StateTransitionFunction.new(transition)
outputFunction = OutputFunction.new(outputTransition)
initialState = "S"

def delTransitionFunction
  if $buffer["first"].nil?
    $result = $result[0...-1]
    "S"
  elsif $buffer["middle"].nil?
    $buffer["first"] = nil
    "S"
  elsif $buffer["next"].nil?
    case $buffer["middle"]
    when "ㅘ", "ㅙ", "ㅚ"
      $buffer["middle"] = "ㅗ"
      "O"
    when "ㅝ", "ㅞ", "ㅟ"
      $buffer["middle"] = "ㅜ"
      "U"
    when "ㅢ"
      $buffer["middle"] = "ㅡ"
      "A"
    else
      $buffer["middle"] = nil
      "V"
    end
  else
    $buffer["next"] = $buffer["last"]
    $buffer["last"] = nil
    case $buffer["next"]
    when "ㄱ" then "K"
    when "ㄴ" then "N"
    when "ㄹ" then "R"
    else
      case $buffer["middle"]
      when "ㅗ" then "O"
      when "ㅜ" then "U"
      when "ㅡ" then "A"
      else "I"
      end
    end
  end
end

hanguelComCho = HangeulAutomata.new(states, symbols, outputs, stateTransitionFunction, outputFunction, initialState, method(:delTransitionFunction))
hanguelComCho.run
