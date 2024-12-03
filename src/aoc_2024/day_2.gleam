import gleam/bool
import gleam/int
import gleam/list
import gleam/set
import gleam/string

pub fn get_diffs(curr: Int, next: Int, rest:List(Int), acc: List(Int)) -> List(Int) {
  case rest {
    [] -> list.append(acc, [next - curr])
    [x, ..rest] -> get_diffs(next, x, rest, list.append(acc, [next - curr]))
  }
}

pub fn list_ints(input: String) -> List(List(Int)) {
  let assert Ok(lines) = input
  |> string.split("\n")
  |> list.map(string.split(_, " "))
  |> list.try_map(list.try_map(_, int.parse))
  lines
}

pub fn pt_1(input: String) {
  use acc, readings <- list.fold(list_ints(input), 0)
  let assert [first, next, ..rest] = readings
  let readset = set.from_list(get_diffs(first, next, rest, []))
  let b = set.is_subset(readset, set.from_list([1, 2, 3])) || set.is_subset(readset, set.from_list([-1, -2, -3]))
  acc + bool.to_int(b)
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
