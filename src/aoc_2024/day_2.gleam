import gleam/int
import gleam/list
import gleam/result
import gleam/string

import gleam/io

// {use x <- list.try_map(string.split(line, " ")) int.parse(x)}
// |> result.unwrap([])
// |> safety_test

pub fn is_safe_reading(line: String) -> Bool {
  list.try_map(string.split(line, " "), fn(x) {int.parse(x)})
  |> result.unwrap([])
  |> safety_test
}

pub fn safety_test(readings: List(Int)) -> Bool {
  case readings {
    [x, y, ..rest] if x != y -> do_safety_test(x, y, rest)
    [_, _] -> True
    _ -> False
  }
}

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

pub fn ints_to_string(ints: List(Int)) -> String {
  list.fold(ints, "", fn(acc, int) {
    acc <> " " <> int.to_string(int)
  })
}

// count the number of safe readings
pub fn pt_1(input: String) {
  use acc, x <- list.fold(string.split(input, "\n"), 0)
  case is_safe_reading(x) {
    True -> acc + 1
    False -> acc
  }
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
