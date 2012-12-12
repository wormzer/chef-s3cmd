# s3cmd [![Build Status](https://secure.travis-ci.org/hectcastro/chef-s3cmd.png?branch=master)](http://travis-ci.org/hectcastro/chef-s3cmd)

## Description

Installs and configures [s3cmd](https://github.com/s3tools/s3cmd).

## Requirements

### Platforms

* CentOS 6.3

### Cookbooks

* python
* yum

## Attributes

* `node["s3cmd"]["version"]` - Version of s3cmd to install.
* `node["s3cmd"]["dir"]` - Directory to install into.
* `node["s3cmd"]["url"]` - URL to the s3cmd archive.
* `node["s3cmd"]["checksum"]` - Checksum of the s3cmd archive.
* `node["s3cmd"]["access_key"]` - AWS access key. If prefixed with `$` an
  environment lookup occurs.
* `node["s3cmd"]["secret_key"]` - AWS secret key. If prefixed with `$` an
  environment lookup occurs.
* `node["s3cmd"]["use_https"]` - Flag for using HTTPS to communicate to S3.
* `node["s3cmd"]["reduced_redundancy"]` - Flag for reduced redundancy S3.
* `node["s3cmd"]["enable_multipart"]` - Enable multipart uploads.
* `node["s3cmd"]["multipart_chunk_size_mb"]` - Multipart upload chunk size in
  megabytes.

## Recipes

* `recipe[s3cmd]` will install s3cmd.

## Usage

This cookbook was created primarily to facilitate data migrations to and from
ephemeral volumes in EC2.  Thus, only a small number of configuration settings
have been templated out.  Pull requests are welcome!
