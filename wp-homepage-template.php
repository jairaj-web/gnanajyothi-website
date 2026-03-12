<?php
/**
 * Template Name: Static HTML Homepage
 * Description: Displays static HTML homepage content
 */

// Read and output the static HTML homepage
$html_file = ABSPATH . 'index.html';
if (file_exists($html_file)) {
    // Get the static HTML content
    $content = file_get_contents($html_file);

    // Extract just the body content (between <body> tags)
    preg_match('/<body[^>]*>(.*)<\/body>/is', $content, $matches);
    $body_content = $matches[1] ?? $content;

    // Output without WordPress theme
    echo $body_content;
} else {
    echo 'Static homepage file not found.';
}
exit;
?>
