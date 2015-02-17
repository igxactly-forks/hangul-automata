#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'


require 'final_project/comRegex.rex'

class RegularExpression < Racc::Parser

module_eval(<<'...end comRegex.racc/module_eval...', 'comRegex.racc', 20)

...end comRegex.racc/module_eval...
##### State transition tables begin ###

racc_action_table = [
     4,     4,     4,     5,     5,     5,     4,     4,     9,     5,
     5,     6,     7,     7,    13,     9,    11 ]

racc_action_check = [
     0,     7,     2,     0,     7,     2,     4,    12,     8,     4,
    12,     1,    10,     1,    10,     3,     6 ]

racc_action_pointer = [
    -3,    11,    -1,    10,     3,   nil,    16,    -2,     3,   nil,
    10,   nil,     4,   nil ]

racc_action_default = [
    -8,    -8,    -2,    -4,    -8,    -7,    -8,    -8,    -3,    -6,
    -8,    14,    -1,    -5 ]

racc_goto_table = [
     8,     1,    12,   nil,   nil,    10,   nil,   nil,   nil,   nil,
     8 ]

racc_goto_check = [
     3,     1,     2,   nil,   nil,     1,   nil,   nil,   nil,   nil,
     3 ]

racc_goto_pointer = [
   nil,     1,    -5,    -2 ]

racc_goto_default = [
   nil,   nil,     2,     3 ]

racc_reduce_table = [
  0, 0, :racc_error,
  3, 8, :_reduce_1,
  1, 8, :_reduce_none,
  2, 9, :_reduce_3,
  1, 9, :_reduce_none,
  3, 10, :_reduce_5,
  2, 10, :_reduce_6,
  1, 10, :_reduce_none ]

racc_reduce_n = 8

racc_shift_n = 14

racc_token_table = {
  false => 0,
  :error => 1,
  "|" => 2,
  "(" => 3,
  ")" => 4,
  "*" => 5,
  :SYMBOL => 6 }

racc_nt_base = 7

racc_use_result_var = false

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "\"|\"",
  "\"(\"",
  "\")\"",
  "\"*\"",
  "SYMBOL",
  "$start",
  "target",
  "factor",
  "term" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'comRegex.racc', 3)
  def _reduce_1(val, _values)
     {"|" => [val[0], val[2]]} 
  end
.,.,

# reduce 2 omitted

module_eval(<<'.,.,', 'comRegex.racc', 6)
  def _reduce_3(val, _values)
     {"." => [val[0], val[1]]} 
  end
.,.,

# reduce 4 omitted

module_eval(<<'.,.,', 'comRegex.racc', 9)
  def _reduce_5(val, _values)
     val[1] 
  end
.,.,

module_eval(<<'.,.,', 'comRegex.racc', 10)
  def _reduce_6(val, _values)
     {"*" => val[0]} 
  end
.,.,

# reduce 7 omitted

def _reduce_none(val, _values)
  val[0]
end

end   # class RegularExpression


