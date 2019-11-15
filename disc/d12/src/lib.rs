// Discussion 12 exercises

// You can test and play around with your code on https://play.rust-lang.org/


// Returns the sum of the even integers in the range [i, j).
// sum_evens(0, 6) -> 6 (0 + 2 + 4)
pub fn sum_evens(i: i32, j: i32) -> i32 {
    0
}

// Returns the Euclidean distance between 2-dimensional points a and b.
// The points are represented as 2-tuples of f64s.
// distance((0.0, 0.0), (1.0, 1.0) -> 1.41...
pub fn distance((ax, ay): (f64, f64), (bx, by): (f64, f64)) -> f64 {
    0.0
}

// Returns the sum of the squared elements of arr.
// sum_squares(&[1, 2] -> 5 (1^2 + 2^2)
pub fn sum_squares(arr: &[i32]) -> i32 {
    0
}

// Adds 1 to each element of the array. (Mutates the array.)
// let mut arr: [i32; 3] = [0, 1, 2];
// raise_1(&mut arr)
// (arr is now [1, 2, 3])
pub fn raise_1(arr: &mut [i32]) {

}

// CHALLENGE PROBLEM (UNGRADED)

// Returns the max consecutive 1s in the array.
// consecutive_1s(&[1, 1, 1, 0, 1, 1]) -> 3
pub fn consecutive_1s(arr: &[i32]) -> i32 {
    0
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn public_test_sum_evens() {
        assert_eq!(6, sum_evens(0, 5));
        assert_eq!(18, sum_evens(4, 10));
        assert_eq!(0, sum_evens(4, 0));
    }

    #[test]
    fn public_test_distance() {
        assert_eq!(0.0, distance((0.0, 0.0), (0.0, 0.0)));
        assert_eq!(1.0, distance((1.0, 2.0), (2.0, 2.0)));
    }

    #[test]
    fn public_test_sum_squares() {
        assert_eq!(0, sum_squares(&[]));
        assert_eq!(14, sum_squares(&[1, 2, 3]));
    }

    #[test]
    fn public_test_raise_1() {
        let mut arr: [i32; 3] = [0, 1, 2];
        raise_1(&mut arr);
        assert_eq!([1, 2, 3], arr);
    }

    #[test]
    fn public_test_consecutive_1s() {
        assert_eq!(0, consecutive_1s(&[]));
        assert_eq!(3, consecutive_1s(&[1, 1, 1, 0, 1, 1]));
    }

}