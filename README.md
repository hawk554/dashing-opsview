dashing-opsview
===============

##Preview
![](http://i.imgur.com/2OxRdyn.png)
An Opsview widget for Dashing based on dashing-nagios

## Description
Simple [Dashing](http://shopify.github.com/dashing) widget (and associated job) to display Opsview info. Based on the widget [nagios](https://github.com/aelse/dashing-nagios).

##Dependencies
You will need to add this to your Gemfile.

    gem 'json'
    gem 'rest-client'

and run `bundle install`.

##Usage

To use this widget copy `opsview.html`, `opsview.coffee`, and `opsview.scss` into `/widgets/opsview` directory. Put the `opsview.rb` file in your `/jobs` folder.

To include the widget in a dashboard, add the following snippet to the dashboard layout file:

    <li data-row="1" data-col="4" data-sizex="1" data-sizey="2">
      <div data-id="opsview" data-view="Opsview" data-unordered="true" data-title="Opsview Overview" data-moreinfo="All Events"></div>
    </li>

##Settings

You will need to add a username, password, and the url for your Opsview server to `opsview.rb` file. It is recommended that you create an account with READ access only.

The job will contact the Opsview server every 30 seconds for an update, but you can change that by editing the job schedule.
