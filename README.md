# Next Accession

This plugin queries our ArchivesSpace instance for the next accession identifier in our numbering sequence, then generates a new minimal accession record (ID + accession date) based on what it finds.

## Background

DU assigns identifiers to its accessions based on the order in which they are processed in a calendar year. The numbering schema is the calendar year, followed by a zero-padded three-digit number identifying its order in the sequence. For example, "2016.100" represents the 100th accession received between 2016 January 1 and 2016 December 31.

## How the plugin works

next_accession contains a [backend API call](https://github.com/duspeccoll/next_accession/blob/master/backend/controllers/next_accession.rb) that takes as input parameter the year in which the accession was processed. It then gets the list of all accessions in the database, builds an array of just those accessions whose identifiers begin with the year provided, and checks to see what the last number in the sequence is. It then iterates it by one and returns the resulting identifier.

The frontend allows the user to input the desired year in a form; it then returns the next identifier to the user with the option to create a new accession record using it. When the "Create Record" button is clicked, a new minimal accession record will be created; the user is then re-directed to that accession record to make whatever edits are required to complete it.

## Screenshots

![Introductory screenshot, displaying the year entry form](http://jackflaps.net/img/next_accession_1.png)

The index page, displaying the form where the year of the accession is entered.

![When the year is entered, an alert displays the next accession ID](http://jackflaps.net/img/next_accession_2.png)

When the year is provided, an alert displays the next accession ID for that year, as well as a button to generate a new accession record.

![The new accession. Further edits can be made by clicking the 'Edit button'](http://jackflaps.net/img/next_accession_3.png)

Clicking the "Create Record" button creates a new, minimum viable accession record. Additional edits may be made as you would edit any accession record in ArchivesSpace.

## Questions

E-mail the author ( kevin dot clair at du dot edu ) or [find me on Twitter](https://twitter.com/jackflaps).
