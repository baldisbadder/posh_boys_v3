<?php
/**
 * Plugin Name: Posh Boys Custom API
 * Description: Custom REST API endpoints for events, offers, and beers.
 * Version: 1.0
 * Author: Vince Wakerley
 */

if (!defined('ABSPATH')) {
    exit; // Exit if accessed directly
}

function get_custom_events_api() {
    global $wpdb;

    $results = $wpdb->get_results("
        SELECT 
            p.ID, 
            p.post_title AS eventname, 
            p.post_content AS eventdescription, 
            meta_date.meta_value AS startdate, 
            meta_time.meta_value AS starttime, 
            image.guid AS imageurl, 
            p.guid AS eventurl
        FROM {$wpdb->prefix}posts AS p
        LEFT JOIN {$wpdb->prefix}postmeta AS meta_date 
            ON p.ID = meta_date.post_id 
            AND meta_date.meta_key = 'em_start_date'
        LEFT JOIN {$wpdb->prefix}postmeta AS meta_time 
            ON p.ID = meta_time.post_id 
            AND meta_time.meta_key = 'em_start_time'
        LEFT JOIN {$wpdb->prefix}postmeta AS meta_image 
            ON p.ID = meta_image.post_id 
            AND meta_image.meta_key = '_thumbnail_id'
        LEFT JOIN {$wpdb->prefix}posts AS image 
            ON meta_image.meta_value = image.ID
        WHERE p.post_type = 'em_event' 
        AND meta_date.meta_value >= UNIX_TIMESTAMP()
        ORDER BY meta_date.meta_value
    ");

    $events = [];
    foreach ($results as $row) {
        $events[] = [
            'id' => $row->ID,
            'eventname' => $row->eventname,
            'eventdescription' => wp_kses_post($row->eventdescription),
            'startdate' => $row->startdate,
            'starttime' => $row->starttime,
            'imageurl' => $row->imageurl ?: '',
            'eventurl' => $row->eventurl,
        ];
    }

    return rest_ensure_response($events);
}

add_action('rest_api_init', function () {
    register_rest_route('poshboys/v1', '/events/', [
        'methods' => 'GET',
        'callback' => 'get_custom_events_api',
        'permission_callback' => '__return_true',
    ]);
});
