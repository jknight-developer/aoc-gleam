import gleam/int
import gleam/list
import gleam/string

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

  use x, y <- list.fold(
    {
      use left, right <- list.map2(left_ints, right_ints)
      int.absolute_value(left - right)
    },
    0
  )
  x + y

  // list.fold(
  //   {
  //     use left, right <- list.map2(left_ints, right_ints)
  //     int.absolute_value(left - right)
  //   },
  //   0,
  //   int.add
  // )

  // use x, y <- list.fold(
  //   list.map2(
  //     left_ints,
  //     right_ints,
  //     fn(left, right) {
  //       int.absolute_value(left - right)
  //     }
  //   ),
  //   0
  // ) 
  // int.add(x, y)

  // list.fold(
  //   list.map2(
  //     left_ints,
  //     right_ints,
  //     fn(left, right) {
  //       int.absolute_value(left - right)
  //     }
  //   ),
  //   0,
  //   int.add
  // )
}

pub fn pt_2(input: String) {
  let #(left_ints, right_ints) = input
  |> string.split("\n")
  |> parse_lines

  list.fold(left_ints, 0, fn(acc, x) {
     acc + {x * list.count(right_ints, fn(y) {x == y})}
  })
}
