import gleam/int
import gleam/list
import gleam/result
import gleam/string

import gleam/io

pub fn do_safety_test(this: Int, next: Int, rest: List(Int)) -> Bool {
  case rest {
    [after, ..rest] -> check3(this, next, after) && do_safety_test(next, after, rest)
    [] -> this != next && int.absolute_value(this - next) <= 3
  }
}

fn check3(this, next, after) -> Bool {
  this != next &&
  next != after &&
  !{this > next && next < after} &&
  !{this < next && next > after} &&
  int.absolute_value(this - next) <= 3 &&
  int.absolute_value(next - after) <= 3
}

// count the number of safe readings
pub fn pt_1(input: String) {
  let lines = input
  |> string.split("\n")
  |> list.map(string.split(_, " "))

  let assert Ok(readings_int) = {
    use line <- list.try_map(lines)
    list.try_map(line, int.parse)
  }
  use acc, readings <- list.fold(readings_int, 0)
  let assert [first, next, ..rest] = readings
  case do_safety_test(first, next, rest) {
    True -> acc + 1
    False -> acc
  }
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
