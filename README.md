![Code Climate](https://codeclimate.com/github/Dervol03/watir-formhandler/badges/gpa.svg)

watir-formhandler
=================

Extends some Watir classes to provide a more comfortale handling for forms and their fields.


## Table of Content

 * [Installation](#installation)
 * [Usage](#usage)
 * [#set](#set)
 * [#field_value](#field_value)
 * [#field](#field)
 * [#fill_in](#fill_in)
 * [#read_field](#read_field)
 * [OptionGroup](#optiongroup)
 * [:start_node](#start_node)
 * [Latest Changes](#latest-changes)


## Installation

Install it from your command line

    gem install watir-formhandler

Install it via Gemfile

    gem 'watir-formhandler'


## Usage

Simply require it wherever you want to use it:

    require 'watir-formhandler'


### #set

All standard HTML form fields now share a common _#set_ interface to change its value, no matter
which subtype the field actually has:

    browser = Watir::Browser.new('example_site')

    browser.text_field(id: 'some_textfield').set('Some Text')
    browser.checkbox(id: 'check_me').set(true)
    browser.select(id: 'select_stuff').set('Option1')


### #field_value

All standard HTML form fields now share a common _#field_value_ interface which returns the
currently set value. But be prudent, the data type may vary, just like the customized value methods.

    browser = Watir::Browser.new('example_site')

    browser.text_field(id: 'my_text').field_value     # String
    browser.checkbox(id: 'check_me').field_value      # true/false
    browser.select(id: 'selection').field_value       # String if only one option is selected
    browser.select(id: 'multiple').field_value        # Array of Strings for several options


### #field

All Containers now have a method to determine a form field by its label, placeholders or ID,
returning the appropriate Watir sub-type class.

    browser = Watir::Browser.new('example_site')
    form = browser.form(id: 'my_form')

    form.field('Some Text Field Label')                # returns TextField if found
    form.field('Some Checkbox Label')                  # returns Checkbox if found
    form.field('Placeholder Text', placeholder: true)  # returns TextField containing a placeholder
                                                       # attribute with 'Placeholder Text'


### #fill_in

All Containers now have a method to search a form field by its label, placeholder or ID and
change its value.

    browser = Watir::Browser.new('example_site')
    form = browser.form(id: 'my_form')

    form.fill_in('Some Text Field', 'Some text')    # enters 'Some text' into the TextField with
                                                    # label 'Some Text Field'

    form.fill_in('Some Text Field', 'Some text', placeholder: true) # enters 'Some text' into the
                                                                    # TextField with placeholder
                                                                    # 'Some Text Field'

### #read_field

All Containers now have a method to search a form field by its label, placeholder or ID and return
its current value.

    browser = Watir::Browser.new('example_site')
    form = browser.form(id: 'my_form')

    form.read_field('Some Text Field')                  # Reads the value of field labeled
                                                        # 'Some Text Field'

    form.fill_in('Some Text Field', placeholder: true)  # Reads the value of a TextField with
                                                        # placeholder 'Some Text Field'


### OptionGroup

A new Container sub class, which represents a group of radio buttons and/or checkboxes. Such a group
may always be referred to, however, to prevent conflicts, _#field_ and _#fill_in_ will only search
for these kind of groups, if the respective options has been activated.

    browser = Watir::Browser.new('example_site')
    form = browser.form(id: 'my_form')

    form.field('OptionsGroupElement')                       # will return the Checkbox or Radio
                                                            # which has label 'OptionsGroupElement'

    form.field('OptionsGroupElement', include_groups: true) # returns OptionGroup node to which
                                                            # the Checkbox/Radio with label
                                                            # 'OptiongsGroupElement' belongs to.



### :start_node

The methods _#field_, _#fill_in_ and _#read_field_ will start their search for the specified label
with the given String on the Container on which it is called, by default. However, you may specify
an arbitrary _start_node_ from which to start, which will probably be most useful when calling the
methods directly on your Watir::Browser instance.

---

---

### Latest Changes

#### Version 2.6.0

* Added #read_field method that works in the exact same way as #fill_in, but which returns the
current value of a field.

#### Version 2.5.0

* Added option to find input fields by ID
* Added option to fill input fields by ID

#### Version 2.4.0

* Renamed the files in such a way that the gem can now properly required with a hyphen like the
  gem name instead of an underscore:

      require 'watir-formhandler'