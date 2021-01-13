# Invoice Creator

A simple invoice creation tool to help you bill your tech clients.

![Sample Invoice](https://user-images.githubusercontent.com/680151/47966699-92c76200-e03c-11e8-8b22-f4fa3e63ef75.png)

## Set up

The codebase has been converted into a Ruby gem so you can just install it with:

```bash
  gem install invoice_creator
```

...and the binary should be available to you globally 🎉

Just make sure to go into the gem's folder and edit the file `config.yml` so that it's tailored to
your needs - define your rate, date format, filename format, etc.

You can do `gem open invoice_creator` for quick access to the gem's folder.

## Usage example

Let's say we want to create an invoice that represents 168 billable hours and has
invoice number set to 10:

```bash
invoice_creator create 168 --number 10
```

Now let's say you want to create the same invoice but also need it to include a row with $150 in reimburseable expenses:
```bash
invoice_creator create 168 150 --number 10
```

For help just run:

```bash
invoice_creator --help
```
