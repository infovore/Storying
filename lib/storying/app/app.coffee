# Skeleton V1.0.2
# Copyright 2011, Dave Gamache
# www.getskeleton.com
# Free to use under the MIT license.
# http://www.opensource.org/licenses/mit-license.php
# 5/20/2011

$(document).ready ->

  # Tabs Activiation
	tabs = $('ul.tabs')

	tabs.each (i) ->
    # Get all tabs
		tab = $(this).find('> li > a')
		tab.click (e) ->
      # Get Location of tab's content
			contentLocation = $(this).attr('href') + "Tab";

      # Let go if not a hashed one
			if contentLocation.charAt(0) == "#"
				e.preventDefault();

        # Make Tab Active
				tab.removeClass('active')
				$(this).addClass('active')

        # Show Tab Content & add active class
				$(contentLocation).show().addClass('active').siblings().hide().removeClass('active')
