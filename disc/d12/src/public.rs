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



