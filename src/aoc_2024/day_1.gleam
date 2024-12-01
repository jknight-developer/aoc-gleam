import gleam/int
import gleam/io
import gleam/list
import gleam/string

// fn parse_lines(lines: List(String)) -> #(List(Int), List(Int)) {
//   list.fold(lines, #([], []), fn(pair, line) {
//     let #(left_list, right_list) = pair
//     let assert [left_item, right_item] = string.split(line, "   ")
//     let assert Ok(left_item) = int.parse(left_item)
//     let assert Ok(right_item) = int.parse(right_item)
//     #([left_item, ..left_list], [right_item, ..right_list])
//   })
// }

// watched the latest Isaac Harris-Holt vid, lol
fn parse_lines(lines: List(String)) -> #(List(Int), List(Int)) {
  use pair, line <- list.fold(over: lines, from: #([], []))
  let #(left_list, right_list) = pair
  let assert [left_item, right_item] = string.split(line, "   ")
  let assert Ok(left_item) = int.parse(left_item)
  let assert Ok(right_item) = int.parse(right_item)
  #([left_item, ..left_list], [right_item, ..right_list])
}

fn sort_pair(pair: #(List(Int), List(Int))) -> #(List(Int), List(Int)) {
  let #(one, two) = pair
  #(list.sort(one, int.compare), list.sort(two, int.compare))
}


pub fn pt_1(input: String) -> Int {
  let #(left_ints, right_ints) = input
  |> string.split("\n")
  |> parse_lines
  |> sort_pair

  list.map2(left_ints, right_ints, fn(left, right) {int.absolute_value(left - right)})
  |> list.fold(0, fn(x, y) {x + y})

  //// left isn't always smaller than right, stupid
  // list.interleave([left_ints, right_ints])
  // |> list.index_fold(0, fn(acc, item, index) {case index {
  //   a if a%2 == 0 -> acc + item
  //   a if a%2 == 1 -> acc - item
  //   _ -> panic
  // }})
}

pub fn pt_2(_input: String) {
  todo as "part 2 not implemented"
}
