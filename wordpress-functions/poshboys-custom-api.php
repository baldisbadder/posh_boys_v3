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

/* Events API */
/**************/

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

/* Beers API */
/**************/

function get_custom_beers_api() {
    global $wpdb;

    $results = $wpdb->get_results("
        SELECT 
            post.ID, 
            post.post_title AS beer_name, 
            post.post_content AS beer_description, 
            post_image.guid AS beer_image_url, 
            availability.term_taxonomy_id AS avail_code
        FROM `audd_posts` AS post
        LEFT JOIN `audd_postmeta` AS meta_image 
            ON post.ID = meta_image.post_id 
            AND meta_image.meta_key = '_thumbnail_id'
        LEFT JOIN `audd_posts` AS post_image 
            ON meta_image.meta_value = post_image.ID
        LEFT JOIN `audd_term_relationships` AS availability 
            ON availability.object_id = post.ID
        WHERE post.post_type = 'beer'
        AND (availability.term_taxonomy_id BETWEEN 22 AND 23)
    ");

    $beers = [];
    foreach ($results as $row) {
        $beers[] = [
            'id' => $row->ID,
            'beername' => $row->beer_name,
            'beerdescription' => wp_kses_post($row->beer_description),
            'imageurl' => $row->beer_image_url ?: '',
            'availcode' => $row->avail_code,
        ];
    }

    return rest_ensure_response($beers);
}

add_action('rest_api_init', function () {
    register_rest_route('poshboys/v1', '/events/', [
        'methods' => 'GET',
        'callback' => 'get_custom_events_api',
        'permission_callback' => '__return_true',
    ]);

    register_rest_route('poshboys/v1', '/beers/', [
        'methods' => 'GET',
        'callback' => 'get_custom_beers_api',
        'permission_callback' => '__return_true',
    ]);

});
