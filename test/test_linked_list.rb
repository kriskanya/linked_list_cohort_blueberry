require 'nss'
require 'linked_list'

class LinkedListTest < MiniTest::Unit::TestCase

  def test_05a_push_get
    ll = LinkedList.new
    payload = "foo"
    ll.push(payload)
    assert_equal(payload, ll.get(0))
  end

  def test_05b_push_get
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    assert_equal("foo", ll.get(0))
  end

  def test_05c_push_get
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    assert_equal("bar", ll.get(1))
  end

  def test_05d_add_multiple_items_get
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll.push("zoo")
    assert_equal("grille", ll.get(2))
  end

  def test_06a_get_negative_index_raises_index_error
    ll = LinkedList.new
    assert_raises IndexError do
      ll.get(-1)
    end
  end

  def test_06b_get_that_doesnt_exist
    ll = LinkedList.new
    assert_raises IndexError do
      ll.get(1)
    end
  end

  def test_06c_get_that_doesnt_exist
    ll = LinkedList.new
    ll.push("bar")
    assert_raises IndexError do
      ll.get(2)
    end
  end

  def test_07a_new_list_size_is_0
    assert_equal(0, LinkedList.new.size)
  end

  def test_07b_list_size
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    assert_equal( 3, ll.size)
  end

  def test_07c_list_size
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    assert_equal( 2, ll.size)
  end

  def test_08a_last_item_for_an_empty_list
    ll = LinkedList.new
    assert_equal(nil, ll.last)
  end

  def test_08b_last_item_for_a_list_with_items
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    assert_equal("grille", ll.last)
  end

  def test_09a_to_s_an_empty_linked_list
    ll = LinkedList.new
    assert_equal("| |", ll.to_s)
  end

  def test_09b_to_s_a_single_item_list
    ll = LinkedList.new
    ll.push("foo")
    assert_equal('| foo |', ll.to_s)
  end

  def test_09c_to_s_a_long_list
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    assert_equal '| foo, bar, grille |', ll.to_s
  end

  # ========= Bonus ========== #

  def test_10a_initialize_takes_seed_argument
    ll = LinkedList.new("foo")
    assert_equal "| foo |", ll.to_s
  end

  def test_10b_initialize_takes_seed_arguments
    ll = LinkedList.new("foo", "bar", "grille")
    assert_equal '| foo, bar, grille |', ll.to_s
  end

  def test_11_bracket_accessor
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    assert_equal("grille", ll[2])
  end

  def test_12a_bracket_assignment
    ll = LinkedList.new("foo", "bar", "grille")
    ll[1] = "bar-be-que"
    assert_equal("bar-be-que", ll[1])
  end

  def test_12b_bracket_assignment_results
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll[1] = "bar-be-que"
    assert_equal '| foo, bar-be-que, grille |', ll.to_s
  end

  def test_13a_delete_item_changes_size
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll.delete(2)

    assert_equal(2, ll.size)
  end

  def test_13b_delete_item_deletes_correct_item
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll.delete(2)

    assert_equal '| foo, bar |', ll.to_s
  end

  def test_13c_delete_item_from_beginning_of_list
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll.delete(0)

    assert_equal '| bar, grille |', ll.to_s
  end

  def test_13d_delete_item_from_middle_of_list
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll.push("dog")
    ll.push("elephant")
    ll.delete(2)

    assert_equal '| foo, bar, dog, elephant |', ll.to_s
  end

  def test_13e_delete_item_from_end_of_list
    ll = LinkedList.new
    ll.push("foo")
    ll.push("bar")
    ll.push("grille")
    ll.push("dog")
    ll.push("elephant")
    ll.delete(4)

    assert_equal '| foo, bar, grille, dog |', ll.to_s
  end

  def test_13f_delete_item_that_doesnt_exist
    ll = LinkedList.new
    assert_raises IndexError do
      ll.delete(1)
    end
  end

  # ========= Index exercise ========== #

  def test_14a_index_of_first_item
    ll = LinkedList.new()
    ll.push("foo")
    ll.push("bar")
    ll.push("good")
    assert_equal(0, ll.index("foo"))
  end

  def test_14b_index_of_middle_item
    ll = LinkedList.new()
    ll.push("foo")
    ll.push("bar")
    ll.push("good")
    assert_equal(1, ll.index("bar"))
  end

  def test_14c_index_of_last_item
    ll = LinkedList.new()
    ll.push("foo")
    ll.push("bar")
    ll.push("good")
    assert_equal(2, ll.index("good"))
  end

  def test_14d_index_of_last_item
    ll = LinkedList.new()
    ll.push("foo")
    ll.push("bar")
    ll.push("good")
    assert_equal(nil, ll.index("terrible"))
  end

  def test_14e_index_of_last_item
    ll = LinkedList.new()
    assert_equal(nil, ll.index("terrible"))
  end

  def test_14f_index_of_duplicate
    ll = LinkedList.new()
    ll.push("foo")
    ll.push("foo")
    ll.push("good")
    assert_equal(0, ll.index("foo"))
  end

  def test_14g_index_of_empty_list
    ll = LinkedList.new()
    assert_equal(nil, ll.index("foo"))
  end


  def test_15a_empty_list_sorted
    ll = LinkedList.new()
    assert ll.sorted?
  end

  def test_15b_single_item_list_sorted
    ll = LinkedList.new("foo")
    assert ll.sorted?
  end

  def test_15c_duplicates_sorted
    ll = LinkedList.new("foo", "foo")
    assert ll.sorted?
  end

  def test_15d_unsorted_list_sorted
    ll = LinkedList.new("foo", "bar")
    assert !ll.sorted?
  end

  def test_15e_sorted_list_sorted
    ll = LinkedList.new("bar", "foo")
    assert ll.sorted?
  end

  def test_15f_list_with_multiple_unsorted_types_sorted
    ll = LinkedList.new(:b, "foo", 1, "bar", 2)
    assert !ll.sorted?
  end

  def test_15g_list_with_multiple_sorted_types_sorted
    ll = LinkedList.new(1, 2, "bar", "foo", :b)
    assert ll.sorted?
  end

  #=== Useful , if you're going to implement bubble sort: ===#
  # Remove the 17x tests if you're going to try for a different sort algorithm.

  def test_16a_swap_middle_items
    ll = LinkedList.new("a","b","c","d")
    assert_equal "| a, b, c, d |", ll.to_s
    ll.swap_with_next(1)
    assert_equal "| a, c, b, d |", ll.to_s
  end

  def test_16b_swap_first_item
    ll = LinkedList.new("a","b","c","d")
    assert_equal "| a, b, c, d |", ll.to_s
    ll.swap_with_next(0)
    assert_equal "| b, a, c, d |", ll.to_s
  end

  def test_16c_swap_middle_items
    ll = LinkedList.new("a","b","c","d")
    assert_equal "| a, b, c, d |", ll.to_s
    ll.swap_with_next(2)
    assert_equal "| a, b, d, c |", ll.to_s
  end

  def test_16d_swap_last_item1
    ll = LinkedList.new("a","b","c","d")
    assert_equal "| a, b, c, d |", ll.to_s
  end

  def test_16e_swap_last_item1
    ll = LinkedList.new("a","b","c","d")
    assert_raises IndexError do
      ll.swap_with_next(3)
    end
  end

  ## SORTING!!!

  def test_17a_sort_empty_list
    ll = LinkedList.new()
    ll.sort!
    assert_equal( "| |", ll.to_s)
  end

  def test_17b_sort_single_item_list
    ll = LinkedList.new("foo")
    ll.sort!
    assert_equal( "| foo |", ll.to_s)
  end

  def test_17c_sort_duplicates
    ll = LinkedList.new("foo", "foo")
    ll.sort!
    assert_equal( "| foo, foo |", ll.to_s)
  end

  def test_17d_sort_unsorted_list
    ll = LinkedList.new("foo", "bar")
    ll.sort!
    assert_equal( "| bar, foo |", ll.to_s)
  end

  def test_17e_sort_sorted_list
    ll = LinkedList.new("bar", "foo")
    ll.sort!
    assert_equal( "| bar, foo |", ll.to_s)
  end

  def test_17f_sort_longer_list
    ll = LinkedList.new("bar", "adda", "grille", "abba", "foo")
    ll.sort!
    assert_equal( "| abba, adda, bar, foo, grille |", ll.to_s)
  end

  def test_17g_sort_list_with_multiple_types
    ll = LinkedList.new(:b, "foo", 1, "bar", 2)
    ll.sort!
    assert_equal( "| 1, 2, bar, foo, b |", ll.to_s)
  end
end
