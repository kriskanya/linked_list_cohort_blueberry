class LinkedList

  attr_accessor :size  # this is a symbol, which is like a unique value
  # returns the @size instance variable
  attr_accessor :first_item

  # this is what attr_accessor :size does:
  #
  # def size
  #   @size
  # end
  #
  # def size=(value)
  #   @size = value
  # end
  #
  # ----

  def initialize(*payloads)  #initialize is just like the constructor in javascript; if there are inputs to the class instantiaion, they are dealt with here
    @size = 0
    @first_item = nil

    payloads.each do |payload|
      push(payload)
    end
  end

  #this is a write method, as it changes some values
  def []=(index, payload)  # this is a special method which takes the index into account, e.g., ll[1] = 'bar-be-que'
    item = get_item(index)
    item.payload = payload
  end

  def [](index)  # this is defining a method called '[]', which we are setting as an alias for the 'get' method
    # this is a 'get' method, as it gets some values
    get_item(index).payload
  end

  alias get []  # makes the method [] an alias for the method 'get'

  def push(value)
    @size += 1

    lli = LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
    else
      @first_item = lli
    end
  end

  def delete(index)
    raise IndexError if index > @size
    @size -= 1
    if index == 0
      @first_item = @first_item.next_item
    else
    prev_item = get_item(index - 1)  # points to the item immediately before the one you want
    next_item = prev_item.next_item.next_item # points to the item immediately after the one you want
    prev_item.next_item = next_item  # changes the value of current item, setting it equal to next time (which gets rid of it)
    end
  end

  def get_item(index)
    raise IndexError if index < 0
    current_item = @first_item
    index.times do
      raise IndexError if current_item.nil?
      current_item = current_item.next_item
    end
    current_item
  end

  def last
    return nil if @first_item.nil?  #checks whether the first item is nil
    current_item = @first_item
    until current_item.next_item == nil
      current_item = current_item.next_item
    end

    current_item.payload
  end

  def to_s
    if @size == 0
      "| |"
    elsif @size > 0
      list = []
      @size.times do |i|
        list.push(self.get(i))  # self is the current object, get is grabbing each item, then it's pushed into the array
      end
      "| " + list.join(', ') + " |"
      #
    end
  end

  def index(payload)
    index = -1  # starts at the end of the linked list
    current_item = @first_item
    until current_item.nil?  # runs the loop until the current_item is nil
      index += 1  # increments index by 1, moving forward in the linked list
      return index if current_item.payload == payload  # returns the index if the payload matches what the test has specified
      current_item = current_item.next_item  # moves to the next item in the ll if it doesn't find a payload match
    end
  end

  def sorted?
    current_item = @first_item
    if @size <= 1
      return true
    else
      until current_item.last?  # goes through the entire ll
        if current_item > current_item.next_item  # if the value of the current item is greater than the value of the next item, then return false (as it's not in order)
          return false
        else  # otherwise, set the current_item to that next_item and continue looping
          current_item = current_item.next_item
        end
      end
      true  # if false is not returned above, return true (this is part of the until loop)
    end
  end

  def swap_with_next(index)
    # this problem is easier to figure out if you draw it out, and assign a variable to each letter
    # A B C D (initial)
    # A C B D (intended result)
    current_item = get_item(index)
    second_item = get_item(index + 1)
    third_item = get_item(index + 2)

    if index == 0 # the edge case where the item's index is 0 and there is no 'previous_item';
      # used when you want to convert A B C D to B A C D
      @first_item = second_item
      second_item.next_item = current_item
      current_item.next_item = third_item
    else # used when you want to convert A B C D to A C B D
      # you're reassigning where each item's 'pointer' points to
      previous_item = get_item(index - 1)
      previous_item.next_item = second_item
      second_item.next_item = current_item
      current_item.next_item = third_item
    end
  end

  def sort!
    current_item = @first_item
    until sorted?  # until sorted is true, do the following
      result = current_item <=> current_item.next_item  # use the comparison operator (we redefined this in linked_list_item.rb)
      if result == 1  # <=> -1 means less than, 0 means both are equal, 1 means greater than - this means that if current_item > current_item.next_item, do the following (we want to swap them)
        index = index(current_item.payload)  # find the index by the payload
        swap_with_next(index)   # swap the two items in the linked list
        sort!  # run sort from the beginning (if you didn't, the current_item = @first_item at the top would remain its old value)
      else
        current_item = current_item.next_item  # else, set current_item to the next_item
      end
    end
  end

  private

  def last_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
  end
end
