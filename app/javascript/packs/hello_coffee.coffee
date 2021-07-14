# Run this example by adding <%= javascript_pack_tag 'hello_coffee' %> to the head of your layout file,
# like app/views/layouts/application.html.erb.

console.log 'Hello world from coffeescript'
jQuery ->
    if $('.pagination').length
        $(window).scroll ->
            url = $('.pagination .next_page').attr('href')
            if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
                $('.pagination').text("Fetching more posts...")
                $.getScript(url)
        $(window).scroll()