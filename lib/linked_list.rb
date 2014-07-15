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

  private

  def last_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
  end
end
