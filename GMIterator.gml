#define ds_linked_list_create
///ds_linked_list_create()

/*  Creates a new Linked list data structure.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**              no arguments
**
**  Returns: The index of newly created list
*/


var list;
list[1] = noone; //next
list[0] = noone; //previous


return list;

#define ds_linked_list_destroy
///ds_linked_list_destroy(id)

/*  destroyed Linked list data structure.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**          Argument0 id: the id to destroy
**
**  Returns: nothing
*/

var list = argument0;
var iterator = ds_linked_list_iterator(list);
while(iterator_has_next(iterator))
{
 iterator_next(iterator);
 iterator_remove(iterator);
}
iterator = 0; //free array
list = 0; //free array

#define ds_linked_list_add_head
///ds_linked_list_add_head(id, value)

/*  Adds an element to the head of the list.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**      Argument1 value: the value to add to the list
**
**  Returns: Nothing
*/

var list = argument0;
var value = argument1;

//creates new link
var previous = noone;
var next = __GMI_ll_get_head_link__(list);
var new_link = __GMI_ll_link_create__(previous, next, value);

//link back
if (next != noone) {
    __GMI_ll_link_set_previous__(next, new_link);
}

//link head
__GMI_ll_set_head_link__(list, new_link);

//link tail if empty
if (__GMI_ll_get_tail_link__(list) == noone) {
    __GMI_ll_set_tail_link__(list, new_link);
}

#define ds_linked_list_add_tail
///ds_linked_list_add_tail(id, value)

/*  Adds an element to the tail of the list.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**      Argument1 value: the value to add to the list
**
**  Returns: Nothing
*/

var list = argument0;
var value = argument1;

//creates new link
var previous = __GMI_ll_get_tail_link__(list);
var next = noone;
var new_link = __GMI_ll_link_create__(previous, next, value);

//link forwards
if (previous != noone) {
    __GMI_ll_link_set_next__(previous, new_link);
}

//link head if empty
if (__GMI_ll_get_head_link__(list) == noone) {
    __GMI_ll_set_head_link__(list, new_link);
}

//link tail
__GMI_ll_set_tail_link__(list, new_link);

#define ds_linked_list_get_head
///ds_linked_list_get_head(id)

/*  Gets the ellement at the head of the list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**
**  Returns: first element in list
*/

var list = argument0;
var link = __GMI_ll_get_head_link__(list);
var data = __GMI_ll_link_get_value__(link);

return data;

#define ds_linked_list_get_tail
///ds_linked_list_get_tail(id)

/*  Gets the ellement at the tail of the list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**
**  Returns: last element in list
*/

var list = argument0;
var link = __GMI_ll_get_tail_link__(list);
var data = __GMI_ll_link_get_value__(link);

return data;

#define ds_linked_list_iterator
///ds_linked_list_iterator(id, [at_ail])

/*  Creates a new iterator for a linked list.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of linked list
** [optional] Argument1 at_tail: start the iterator at tail of list
**
**  Returns: The index of newly created iterator
*/

var list = argument[0];
var at_tail = false;
if (argument_count == 2) { at_tail = argument[1]; }
var iterator;
iterator[4] = noone;
iterator[0] = GMIterator_linked_list;
iterator[1] = list;
var next, previous;
if (at_tail) {
    next = noone;
    previous = __GMI_ll_get_tail_link__(list);
} else {
    next = __GMI_ll_get_head_link__(list);
    previous = noone;
}
iterator[2] = previous;
iterator[3] = next;

return iterator;


#define ds_linked_list_sort
///ds_linked_list_sort(id)

/*  sorts the linked list.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of linked list
**
**
**  Returns: nothing
**
**  TODO: Uses bubble sort, change to quicksort
*/

var list = argument0;
var size = ds_linked_list_size(list);
if (size > 1) {
    for(var i = size + 1; i > 0; i--) {
        var prev = __GMI_ll_get_head_link__(list);
        for(var j = i; j > 0; j--) {
            var next = __GMI_ll_link_get_next__(prev);
            var pv = __GMI_ll_link_get_value__(prev);
            var nv = __GMI_ll_link_get_value__(next);
            if (pv > nv) {
                __GMI_ll_link_swap__(list, prev, next);
            }
            prev = next;
        }
    }
}

#define ds_linked_list_size
///ds_linked_list_size(id)

/*  returns the size of the linked list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of linked list
**
**
**  Returns: size
*/

var list = argument0;
var iterator = ds_linked_list_iterator(list);

var count = 0;
while(iterator_has_next(iterator)) {
    iterator_next(iterator);
    count++;
}
iterator_destroy(iterator);

return count;

#define __GMI_ll_link_create__
///__GMI_ll_link_create__(previous, next, data)

// ! called by dl_linked_list functions only
/*  Creates a new link for linked list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 previous: the previous link
**      Argument1 next:     the next link
**      Argument2 data:     the data to store in the link
**
**  Returns: The index of newly created link
*/
gml_pragma("forceinline");
var previous = argument0;
var next = argument1;
var data = argument2;

var link;
link[2] = data;
link[0] = previous;
link[1] = next;


return link;

#define __GMI_ll_link_get_previous__
///__GMI_ll_link_get_previous__(id)

/*  Finds the previous link
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the link
**
**  Returns: The next link
*/
gml_pragma("forceinline");
return argument0[0];

#define __GMI_ll_link_set_previous__
///__GMI_ll_link_set_previous__(link, previous)

/*  Sets the previous link for a llink
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 link: the link to change the previous of
**      Argument1 previous: the previous link
*/
gml_pragma("forceinline");
argument0[@ 0] = argument1;

#define __GMI_ll_link_get_next__
///__GMI_ll_link_get_next__(id)

/*  Finds the tail link in a list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the link
**
**  Returns: The next link
*/
gml_pragma("forceinline");
return argument0[1];

#define __GMI_ll_link_set_next__
///__GMI_ll_link_set_next__(link, next)

/*  Sets the next link for a llink
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 link: the link to change the previous of
**      Argument1 next: the next link
*/
gml_pragma("forceinline");
argument0[@ 1] = argument1;

#define __GMI_ll_link_get_value__
///__GMI_ll_link_get_value__(id)

/*  Finds the value stored in link
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the link
**
**  Returns: The value of the link
*/

gml_pragma("forceinline");
return argument0[2];

#define __GMI_ll_link_swap__
///__GMI_ll_link_swap__(list, link a, link b)

/*  Swaps two links
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 link a:  The first link
**      Argument1 link b: the second link
**
**  Returns: nothing
**
**  !!link a must just before link b
**  TODO: fix for all cases
*/

var list = argument0;
var link_a = argument1;
var link_b = argument2;

var prev = __GMI_ll_link_get_previous__(link_a);
var next = __GMI_ll_link_get_next__(link_b);

if (prev == noone) {
    __GMI_ll_set_head_link__(list, link_b);
} else {
    __GMI_ll_link_set_next__(prev, link_b);
}

if (next == noone) {
    __GMI_ll_set_tail_link__(list, link_a);
} else {
    __GMI_ll_link_set_previous__(next, link_a);
}

__GMI_ll_link_set_previous__(link_b, prev);
__GMI_ll_link_set_next__(link_b, link_a);
__GMI_ll_link_set_previous__(link_a, link_b);
__GMI_ll_link_set_next__(link_a, next);

#define __GMI_ll_get_head_link__
///__GMI_ll_get_head_link__(id)

/*  Finds the head link in a list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**
**  Returns: The head link
*/
gml_pragma("forceinline");
return argument0[0];

#define __GMI_ll_set_head_link__
///__GMI_ll_set_head_link__(id, link)

/*  sets the head link in a list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**      Argument1 link:  the new head link
**
**  Returns: nothing
*/

gml_pragma("forceinline");
argument0[@ 0] = argument1;

#define __GMI_ll_set_tail_link__
///__GMI_ll_set_tail_link__(id, link)

/*  sets the tail link in a list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**      Argument1 link:  the new tail link
**
**  Returns: nothing
*/

gml_pragma("forceinline");
argument0[@ 1] = argument1;

#define __GMI_ll_get_tail_link__
///__GMI_ll_get_tail_link__(id)

/*  Finds the tail link in a list
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 id:    the index of the linked list
**
**  Returns: The tail link
*/

gml_pragma("forceinline");
return argument0[1];

#define __GMI_ill_next__
///__GMI_ill_next__(iterator)
/*  Retruns the next element in iteration for linked list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The next element
*/

var iterator = argument0;

if !__GMI_ill_has_next__(iterator) {
 show_error("No next element", true);
}

var next = __GMI_ill_get_next__(iterator);
var value = __GMI_ll_link_get_value__(next);

var previous = next;
next = __GMI_ll_link_get_next__(next);

__GMI_ill_set_previous__(iterator, previous);
__GMI_ill_set_next__(iterator, next);
__GMI_ill_set_returned__(iterator, previous);

return value;

#define __GMI_ill_previous__
///__GMI_ill_previous__(iterator)
/*  Retruns the previous element in iteration for linked list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The previous element
*/

var iterator = argument0;

if !__GMI_ill_has_previous__(iterator) {
 show_error("No next element", true);
}

var previous = __GMI_ill_get_previous__(iterator);
var value = __GMI_ll_link_get_value__(previous);

var next = previous;
previous = __GMI_ll_link_get_previous__(previous);

__GMI_ill_set_previous__(iterator, previous);
__GMI_ill_set_next__(iterator, next);
__GMI_ill_set_returned__(iterator, previous);


return value;

#define __GMI_ill_has_next__
///__GMI_ill_has_next__(iterator)
/*  Retruns the if iterator has next element for linked list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: if next element exists
*/

var iterator = argument0;
var next = __GMI_ill_get_next__(iterator);
return (next != noone);

#define __GMI_ill_has_previous__
///__GMI_ill_has_previous__(iterator)
/*  Retruns the if iterator has previous element for linked list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: if previous element exists
*/

var iterator = argument0;
var previous = __GMI_ill_previous__(iterator);
return (previous != noone);

#define __GMI_ill_remove__
///__GMI_ill_remove__(iterator)
/*  removes the last element returned by iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: nothing
*/

var iterator = argument0;

var remove = __GMI_ill_get_returned__(iterator);
if (remove == noone) {
    show_error("Must iterate over element before removing", false);
} else {
    var previous = __GMI_ll_link_get_previous__(remove);
    var next = __GMI_ll_link_get_next__(remove);
    var list = __GMI_ill_get_list__(iterator);
    
    if (previous == noone) {
        __GMI_ll_set_head_link__(list, next);
    } else {
        __GMI_ll_link_set_next__(previous, next);
    }
    
    if (next == noone) {
        __GMI_ll_set_tail_link__(list, previous);
    } else {
        __GMI_ll_link_set_previous__(next, previous);
    }
    
    remove = 0; //free array
    
    __GMI_ill_set_previous__(iterator, previous);
    __GMI_ill_set_next__(iterator, next);
    __GMI_ill_set_returned__(iterator, noone);
}

#define __GMI_ill_add__
///__GMI_ill_add__(iterator, value)
/*  adds an element to the linked list ( 1 2|4 -> 1 2 3 | 4)
**  Author: Felix Bridault
**  Date: 02/03/16
**  Revised: 06/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 value: the value to add
**
**  Returns: nothing
*/

var iterator = argument0;
var value = argument1;

var previous = __GMI_ill_get_previous__(iterator);
var next = __GMI_ill_get_next__(iterator);
var new_link = __GMI_ll_link_create__(previous, next, value);
var list = __GMI_ill_get_list__(iterator);
if (previous == noone) {
    __GMI_ll_set_head_link__(list, new_link);
} else {
    __GMI_ll_link_set_next__(previous, new_link);
}

if (next == noone) {
    __GMI_ll_set_tail_link__(list, new_link);
} else {
    __GMI_ll_link_set_previous__(next, new_link);
}

__GMI_ill_set_previous__(iterator, new_link);

#define __GMI_ill_get_next__
///__GMI_ill_get_next__(iterator)

/*  retruns next link in iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The next link in iterator
*/
gml_pragma("forceinline");
return argument0[3];

#define __GMI_ill_get_previous__
///__GMI_ill_get_previous__(iterator)

/*  retruns previous link in iterator
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The previous link in iterator
*/
gml_pragma("forceinline");
return(argument0[2]);

#define __GMI_ill_get_returned__
///__GMI_ill_get_returned__(iterator)

/*  retruns returned link in iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The returned link in iterator
*/
gml_pragma("forceinline");
return argument0[4];

#define __GMI_ill_get_list__
///__GMI_ill_get_list__(iterator)

/*  retruns list of iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The list of iterator
*/

gml_pragma("forceinline");
return argument0[1];

#define __GMI_ill_set_next__
///__GMI_ill_set_next__(iterator, link)

/*  sets next of iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 list: the next link
**
**  Returns: nothing
*/

gml_pragma("forceinline");
argument0[@ 3] = argument1;

#define __GMI_ill_set_previous__
///__GMI_ill_set_previous__(iterator, link)

/*  sets previous of iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 list: the previous link
**
**  Returns: nothing
*/

gml_pragma("forceinline");
argument0[@ 2] = argument1;

#define __GMI_ill_set_returned__
///__GMI_ill_set_returned__(iterator, link)

/*  sets returned of iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 list: the returned link
**
**  Returns: nothing
*/

gml_pragma("forceinline");
argument0[@ 4] = argument1;

#define __GMI_var_get_type__
///__GMI_var_get_type__(variable)

/*  Checks the buffer_type for given variable
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**      Argument0 variable: the varaible to check
**
**  Returns: The buffer type to use with variable
*/
var variable = argument0;

if (is_real(variable)) {
    return buffer_f64;
}

if (is_string(variable)) {
    return buffer_string;
}

#define iterator_next
///iterator_next(id)

/*  Retruns the next element in iteration
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The next element
*/

var iterator = argument0;
var type = iterator[0];

switch(type) {
    case GMIterator_linked_list: 
        return __GMI_ill_next__(iterator);
        break;
    case GMIterator_array_list:
        return __GMI_ial_next__(iterator);
        break;
    default:
        show_error("unknown ds type", true);
        break;
}

#define iterator_previous
///iterator_previous(id)

/*  Retruns the previous element in iteration
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The previous element
*/

var iterator = argument0;
var type = iterator[0];

switch(type) {
    case GMIterator_linked_list: 
        return __GMI_ill_previous__(iterator);
        break;
    case GMIterator_array_list:
        return __GMI_ial_previous__(iterator);
        break;
    default:
        show_error("unknown ds type", true);
        break;
}

#define iterator_has_next
///iterator_has_next(id)

/*  Retruns if the next element in iteration exists
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: if there is next element
*/

var iterator = argument0;
var type = iterator[0];

switch(type) {
    case GMIterator_linked_list: 
        return __GMI_ill_has_next__(iterator);
        break;
    case GMIterator_array_list:
        return __GMI_ial_has_next__(iterator);
        break
    default:
        show_error("unknown ds type", true);
        break;
}

#define iterator_has_previous
///iterator_has_previous(id)

/*  Retruns if the previous element in iteration exists
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: if there is previous element
*/

var iterator = argument0;
var type = iterator[0];

switch(type) {
    case GMIterator_linked_list: 
        return __GMI_ill_has_previous__(iterator);
        break;
    case GMIterator_array_list:
        return __GMI_ial_has_previous__(iterator);
        break;
    default:
        show_error("unknown ds type", true);
        break;
}

#define iterator_remove
///iterator_remove(iterator)

/*  Removes the last element returned by iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: nothing
*/

var iterator = argument0;
var type = iterator[0];

switch(type) {
    case GMIterator_linked_list: 
        return __GMI_ill_remove__(iterator);
        break;
    case GMIterator_array_list:
        return __GMI_ial_remove__(iterator);
        break;
    default:
        show_error("unknown ds type", true);
        break;
}

#define iterator_add
///iterator_add(iterator, value)

/*  adds element to iterable: 1 2|4 -> 1 2 3|4
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**
**  Returns: nothing
**
**  places a value between previous and next. next will be unafected, and previous ill return new element.
*/

var iterator = argument0;
var value = argument1;
var type = iterator[0];

switch(type) {
    case GMIterator_linked_list: 
        return __GMI_ill_add__(iterator, value);
        break;
    case GMIterator_array_list:
        return __GMI_ial_add__(iterator, value);
        break;
    default:
        show_error("unknown ds type", true);
        break;
}

#define iterator_destroy
///iterator_destroy(iterator)

/*  frees the iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: nothing
*/

argument0 = 0;

#define ds_list_iterator
///ds_list_iterator(id)

/*  Creates a new iterator for a list.
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of linked list
** [optional] Argument1 at_tail: start the iterator at tail of list
**
**  Returns: The index of newly created iterator
*/

var list = argument[0];
var at_tail = false;
if (argument_count == 2) { at_tail = argument[1]; }

//create iterator buffer [0type, 1 list, 2 pos, 3 oldpos]
var iterator;
iterator[0] = GMIterator_array_list;
iterator[1] = list;
var pos = 0;
if (at_tail) {
    pos = ds_list_size(list);
}
iterator[2] = pos;
iterator[3] = pos;
return iterator;

#define __GMI_ial_next__
///__GMI_ial_next__(iterator)
/*  Returnns the next element in iteration for array list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The next element
*/


var iterator = argument0;
if !__GMI_ial_has_next__(iterator) {
    show_error("no next element", true);
} else {
    var list = __GMI_ial_get_list__(iterator);
    var pos = __GMI_ial_get_pos__(iterator);
    var value = ds_list_find_value(list, pos);
    __GMI_ial_set_pos__(iterator, pos + 1);
    __GMI_ial_set_old_pos__(iterator, pos);
    return value;
}


#define __GMI_ial_remove__
///__GMI_ial_remove__(iterator)
/*  removes previously iterated value
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: nothing
*/


var iterator = argument0;
var oldpos = __GMI_ial_get_old_pos__(iterator);
var pos = __GMI_ial_get_pos__(iterator);
if (oldpos == pos) {
    show_error("must iterate over element before removing", true);
} else {
    var list = __GMI_ial_get_list__(iterator);
    ds_list_delete(list, oldpos);
    
    if (oldpos < pos) {
        __GMI_ial_set_pos__(iterator, pos - 1);
        __GMI_ial_set_old_pos__(iterator, pos - 1);
    }
}


#define __GMI_ial_add__
///__GMI_ial_add__(iterator, value)
/*  adds value, and iterates over ( 1 2 | 4 -> 1 2 3 | 4
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 value: the value to add
**
**  Returns: nothing
*/


var iterator = argument0;
var value = argument1;

var pos = __GMI_ial_get_pos__(iterator);
var list = __GMI_ial_get_list__(iterator);
ds_list_insert(list, pos, value);
__GMI_ial_set_pos__(iterator, pos + 1);
__GMI_ial_set_old_pos__(iterator, pos);


#define __GMI_ial_previous__
///__GMI_ial_previous__(iterator)
/*  Returnns the previous element in iteration for array list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The previous element
*/

var iterator = argument0;
if !__GMI_ial_has_previous__(iterator) {
    show_error("no previous element", true);
} else {
    var list = __GMI_ial_get_list__(iterator);
    var pos = __GMI_ial_get_pos__(iterator);
    var value = ds_list_find_value(list, pos - 1);
    __GMI_ial_set_pos__(iterator, pos - 1);
    __GMI_ial_set_old_pos__(iterator, pos);
    return value;
}


#define __GMI_ial_has_next__
///__GMI_ial_has_next__(iterator)
/*  Returnns if next element exits
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: if next exists
*/

var iterator = argument0;
var list = __GMI_ial_get_list__(iterator);
var pos = __GMI_ial_get_pos__(iterator);
return (pos < ds_list_size(list));

#define __GMI_ial_has_previous__
///__GMI_ial_has_previous__(iterator)
/*  Returnns if previous element exits
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: if next exists
*/

var iterator = argument0;
var pos = __GMI_ial_get_pos__(iterator);
return (pos > 0);

#define __GMI_ial_get_pos__
///__GMI_ial_get_pos__(iterator)
/*  Returnns the position in iteration for array list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The pos
*/
gml_pragma("forceinline");
return argument0[2];

#define __GMI_ial_get_old_pos__
///__GMI_ial_get_old_pos__(iterator)
/*  Returnns the old position in iteration for array list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The old pos
*/
gml_pragma("forceinline");
return argument0[3];

#define __GMI_ial_get_list__
///__GMI_ial_get_list__(iterator)
/*  Returnns the list of iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**
**  Returns: The list
*/
gml_pragma("forceinline");
return argument0[1];

#define __GMI_ial_set_pos__
///__GMI_ial_set_pos__(iterator, pos)
/*  sets the position in iteration for array list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 pos: the new pos
**
**  Returns: nothing
*/

gml_pragma("forceinline");
return argument0[@ 2] = argument1;

#define __GMI_ial_set_old_pos__
///__GMI_ial_set_old_pos__(iterator, old pos)
/*  sets the old position in iteration for array list iterator
**  Author: Felix Bridault
**  Date: 02/03/16
**  Arguments:
**            Argument0 id: the index of iterator
**            Argument1 pos: the new old pos
**
**  Returns: nothing
*/

gml_pragma("forceinline");
return argument0[@ 3] = argument1;

