# Primo

[![Code Climate](https://codeclimate.com/github/cbetta/primo.png)](https://codeclimate.com/github/cbetta/primo)

A configurable default Rails stack.

This is a proof of concept and any feedback is welcome either on [GitHub](https://github.com/cbetta/primo/issues), [Twitter](http://twitter.com/cbetta), or [email](mailto:primo@cgb.im).

Inspired by Steve Klabnik's article ["Rails has Two Default Stacks"](http://words.steveklabnik.com/rails-has-two-default-stacks) and the awesome [Rails application templates](http://edgeguides.rubyonrails.org/rails_application_templates.html#gem-args).

## Why is this useful?

Rails application templates are awesome, especially for hackers that often need to set up the same basic app, but also for companies that want to promote their best pratices. Sadly the ecosystem around them seems to be quite limited. Primo tries to solve this by adding a command line interface for defining your default template and share it with others.

At the moment Primo comes with [1 bundle of templates](https://github.com/cbetta/primo-templates) but it is relatively easy to add your own.

## Requirements

* Rails >= 1.9.2
* Git

## Usage

### Basic

    $ gem install primo

    $ primo new app_name #instead of "rails new app_name"

This generates a PostgreSQL/HAML/Rspec Rails app using [this admittedly very basic template](https://github.com/cbetta/primo-templates/blob/master/prime.rb).

You can specify a different template as follows

    $ primo new app_name --template default-rails # this just runs a plain rails install

### Advanced

Using a different template is easy. You can specify them any remote repository and bring in those templates.

    # add a new remote
    $ primo remote add <name> <git url> #pulls the templates into ~/primo_remotes/<name>/

    # list all remotes
    $ primo remote list

    # remove a remote
    $ primo remote rm <name>

    # update a remote by pulling in changes
    $ primo remote pull <name>

To use templates and set a different default:

    # list all templates in all pulled remotes
    $ primo template list
    +---------------+---------+-----------------------------------------------+
    | Name          | Remote  | Path                                          |
    +---------------+---------+-----------------------------------------------+
    | default-rails | default | /home/vagrant/.primo_remotes/default/rails.rb |
    | default-prime | default | /home/vagrant/.primo_remotes/default/prime.rb |
    +---------------+---------+-----------------------------------------------+

    # view a template content
    $ primo template show <name>

    # open a template in your editor
    $ primo template open <name>

    # set your default template to use when creating new projects
    $ primo template default <name>

    # see your current default
    $ primo template default

## Release notes

* **0.1.0** Changed syntax. Now uses infrastructure that supports remotes
* **0.0.6** Allows for overriding of templates
* **0.0.5** Adds option to set custom default
* **0.0.4** Fixing template
* **0.0.3** Removed direct Rails dependency
* **0.0.2** Added simple installer for "Prime stack"
* **0.0.1** Gem skeleton

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

See [LICENSE](https://github.com/cbetta/primo/blob/master/LICENSE)

