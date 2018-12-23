
/**
 * This file is part of the Phalcon Framework.
 *
 * (c) Phalcon Team <team@phalconphp.com>
 *
 * For the full copyright and license information, please view the LICENSE.txt
 * file that was distributed with this source code.
 */

namespace Phalcon\Cache\Frontend;

use Phalcon\Cache\FrontendInterface;

/**
 * Phalcon\Cache\Frontend\Base64
 *
 * Allows to cache data converting/deconverting them to base64.
 *
 * This adapter uses the base64_encode/base64_decode PHP's functions
 *
 *<code>
 *<?php
 *
 * // Cache the files for 2 days using a Base64 frontend
 * $frontCache = new \Phalcon\Cache\Frontend\Base64(
 *     [
 *         "lifetime" => 172800,
 *     ]
 * );
 *
 * //Create a MongoDB cache
 * $cache = new \Phalcon\Cache\Backend\Mongo(
 *     $frontCache,
 *     [
 *         "server"     => "mongodb://localhost",
 *         "db"         => "caches",
 *         "collection" => "images",
 *     ]
 * );
 *
 * $cacheKey = "some-image.jpg.cache";
 *
 * // Try to get cached image
 * $image = $cache->get($cacheKey);
 *
 * if ($image === null) {
 *     // Store the image in the cache
 *     $cache->save(
 *         $cacheKey,
 *         file_get_contents("tmp-dir/some-image.jpg")
 *     );
 * }
 *
 * header("Content-Type: image/jpeg");
 *
 * echo $image;
 *</code>
 */
class Base64 implements FrontendInterface
{

	protected _frontendOptions;

	/**
	 * Phalcon\Cache\Frontend\Base64 constructor
	 */
	public function __construct(array frontendOptions = [])
	{
		let this->_frontendOptions = frontendOptions;
	}

	/**
	 * Returns the cache lifetime
	 */
	public function getLifetime() -> int
	{
		var options, lifetime;
		let options = this->_frontendOptions;
		if typeof options == "array" {
			if fetch lifetime, options["lifetime"] {
				return lifetime;
			}
		}
		return 1;
	}

	/**
	 * Check whether if frontend is buffering output
	 */
	public function isBuffering() -> bool
	{
		return false;
	}

	/**
	 * Starts output frontend. Actually, does nothing in this adapter
	 */
	public function start()
	{

	}

	/**
	 * Returns output cached content
	 *
	 * @return string
	 */
	public function getContent()
	{
		return null;
	}

	/**
	 * Stops output frontend
	 */
	public function stop()
	{

	}

	/**
	 * Serializes data before storing them
	 */
	public function beforeStore(var data) -> string
	{
		return base64_encode(data);
	}

	/**
	 * Unserializes data after retrieval
	 */
	public function afterRetrieve(var data) -> var
	{
		return base64_decode(data);
	}
}
