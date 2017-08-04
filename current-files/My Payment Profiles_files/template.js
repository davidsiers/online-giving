// JavaScript Document
$(function () {
    if ($('.dropdown-toggle').length > 0) {
        $('.dropdown-toggle').dropdownHover({
            delay: 0
        });
    }
    if ($('.content, .sidebar').length > 0) {
        $('.content, .sidebar').matchHeight();
    }
});