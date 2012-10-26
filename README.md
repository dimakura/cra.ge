# CRA.ge

`cra.ge` is a gem for working with Georgian Civil Registry Agency web-services.

## Configure

First of all you need to configure the gem. You need a PEM certificate file for this:

```ruby
CRA.config.pem_file = '/home/dimakura/certificates/my-company.pem'
```

## Getting person information by private number

If you have person's private number (11 digits code), then you can get the last entry in CRA database,
like this:

```ruby
private_number = '02001000490'
person_info = CRA.serv.by_personal_id(private_number) # CRA::PassportInfo
```

## Getting person infromation by id card

You can get person's last document by their id card information:

```ruby
CRA.serv.by_id_card('გ', '1355876')
```

## Getting full documentation for the person

If you have first/last names of the person and know their birthdate, then it's easy to get
full list of documentation for this person:

```ruby
fname = 'დიმიტრი'
lname = 'ყურაშვილი'
year, month, day = 1979, 4, 4
docs = CRA.serv.list_by_name_and_dob(lname, fname, year, month, day) # array of CRA::PassportInfo
```