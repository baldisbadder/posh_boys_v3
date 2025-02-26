<?php
/**
 * Plugin Name: Custom CORS Enabler
 * Description: Enables CORS for WordPress REST API & static assets.
 */

if (!defined('ABSPATH')) {
    exit;
}

// ✅ Apply CORS headers safely
function custom_cors_headers() {
    if (!headers_sent()) {
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
        header("Access-Control-Allow-Headers: Content-Type, Authorization");
    }

    // ✅ Handle OPTIONS requests properly
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        wp_send_json(null, 200);
    }
}

// ✅ Hook into REST API requests
add_action('rest_api_init', function () {
    add_filter('rest_pre_serve_request', function ($value) {
        custom_cors_headers();
        return $value;
    });
});

// ✅ Hook into ALL requests (images, CSS, etc.)
add_action('init', 'custom_cors_headers');
?>
