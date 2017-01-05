# Dealerdirect: PHP Quality Assurance Tools

[![Travis](https://img.shields.io/travis/DealerDirect/php-qa-tools.svg?style=flat-square)](https://travis-ci.org/DealerDirect/php-qa-tools)
[![Dependency Status](https://www.versioneye.com/user/projects/580939a4d65a77002f5eab70/badge.svg?style=flat-square)](https://www.versioneye.com/user/projects/580939a4d65a77002f5eab70)
[![Packagist](https://img.shields.io/packagist/dt/dealerdirect/qa-tools.svg?style=flat-square)](https://packagist.org/packages/dealerdirect/qa-tools)
![Maintenance](https://img.shields.io/maintenance/yes/2016.svg?style=flat-square)
![Awesome](https://img.shields.io/badge/awesome%3F-yes-brightgreen.svg?style=flat-square)
[![License](https://img.shields.io/github/license/dealerdirect/php-qa-tools.svg?style=flat-square)](https://github.com/DealerDirect/php-qa-tools)

*“If you don’t have time to do it right you must have time to do it over.”*

This is essentially a Composer meta package, creating a fast, easy and
convenient way of installing all PHP Quality Assurance tools.

## Contents

You'll get the following tools by depending on this package:

### Linters / Fixers

* **[JSON Lint]**: JSON Lint for PHP
* **[PHP Coding Standards Fixer]**: A tool to automatically fix PHP coding standards issues
* **[PHP Parallel Lint]**: Check syntax of PHP files faster than serial check with fancier output
* **[PHP_CodeSniffer]**: Detects violations of a defined set of coding standards

### Quality Assistance

* **[GrumPHP]**: Githooks for PHP QA tooling
* **[PHP_Depend]**: Software metrics for PHP
* **[PHPCPD]**: Copy/Paste Detector
* **[PHPLOC]**: Quickly measure the size of a PHP project
* **[PhpMetrics]**: A static analysis tool for PHP
* **[PHPMD]**: PHP Mess Detector
* **[SensioLabs Security Checker]**: Checks for dependencies with known security vulnerabilities

### Test Related

* **[Behat]**: BDD framework for PHP
* **[Codeception]**: Modern full-stack testing framework for PHP
* **[Mink]**: PHP 5.3+ web browser emulator abstraction
* **[ParaTest]**: Parallel testing for PHPUnit
* **[PHPUnit]**: Testing framework for PHP

### Other

Other packages that you'll get:

* **[Behat Mink]**: Mink extension for Behat
* **[Composer Versions Check]**: Checks if packages are up to date to last major versions after update
* **[Mink Goutte Driver]**: Goutte driver for Mink framework
* **[Mink Selenium2 Driver]**: Selenium2 (WebDriver) driver for Mink framework
* **[PHP_CodeSniffer Composer Installer]**: For installing PHP_CodeSniffer coding standards
* **[PHPCompatibility]**: PHP Compatibility checks for PHP_CodeSniffer
* **[prestissimo]**: Composer parallel install plugin
* **[Tombstone Analyzer]**: Report generation for Tombstones

## Suggested

The following packages are suggested:

* **[ApiGen]**: Smart and Readable Documentation for your PHP project
* **[Mockery]**: A simple yet flexible PHP mock object framework
* **[PHP_CodeBrowser]**: A code browser that augments the code with information from various QA tools
* **[phpcov]**: Command-line frontend for the PHP_CodeCoverage library
* **[phpDocumentor]**: Documentation generator for PHP
* **[phpDox]**: Documentation generator for PHP
* **[Sami]**: An API documentation generator

[Behat]: http://behat.org
[Codeception]: http://codeception.com
[GrumPHP]: https://github.com/phpro/grumphp
[JSON Lint]: https://github.com/Seldaek/jsonlint
[Mink]: http://mink.behat.org
[ParaTest]: https://github.com/brianium/paratest
[PHP Coding Standards Fixer]: http://cs.sensiolabs.org
[PHP Parallel Lint]: https://github.com/JakubOnderka/PHP-Parallel-Lint
[PHP_CodeSniffer]: https://github.com/squizlabs/PHP_CodeSniffer
[PHP_Depend]: https://github.com/pdepend/pdepend
[PHPCPD]: https://github.com/sebastianbergmann/phpcpd
[PHPLOC]: https://github.com/sebastianbergmann/phploc
[PHPMD]: https://phpmd.org
[PhpMetrics]: http://www.phpmetrics.org
[PHPUnit]: https://phpunit.de
[SensioLabs Security Checker]: https://security.sensiolabs.org
[Tombstone Analyzer]: https://github.com/scheb/tombstone-analyzer

[Behat Mink]: https://github.com/Behat/MinkExtension
[Composer Versions Check]: https://github.com/Soullivaneuh/composer-versions-check
[Mink Goutte Driver]: https://github.com/minkphp/MinkGoutteDriver
[Mink Selenium2 Driver]: https://github.com/minkphp/MinkSelenium2Driver
[PHP_CodeSniffer Composer Installer]: https://github.com/DealerDirect/phpcodesniffer-composer-installer
[PHPCompatibility]: https://github.com/wimg/PHPCompatibility
[Prestissimo]: https://github.com/hirak/prestissimo

[ApiGen]: http://www.apigen.org
[Mockery]: https://github.com/padraic/mockery
[PHP_CodeBrowser]: https://github.com/mayflower/PHP_CodeBrowser
[PhpCov]: https://github.com/sebastianbergmann/phpcov
[PhpDocumentor]: https://www.phpdoc.org
[PhpDox]: http://phpdox.de
[Sami]: https://github.com/FriendsOfPHP/sami

## Usage

This is a simple metapackage which can be used in two different ways; globally installed or on a per project basis.

Both methods have their pros (+) and cons (-).

**Global installation**:
* \+ All tools are present anywhere on your system
* \+ Can be used on any codebase, even the ones that don't use Composer.
* \- You'll have to update manually, since it's not a project, versioning is not managed.

*Per project installation*:
* \+ Versioning (update/installation) is provided in the project
* \- Tools not available system wide. You'll need to execute them from a specific path.

These methods are not mutual exclusive. You can have your global installed version, which can be used anywhere, but
still use the one provided in a project.

## Installation

### Global installation

The following script will install a system wide Composer for you, including the QA tools.

```bash
bash <(curl -S https://raw.githubusercontent.com/DealerDirect/php-qa-tools/master/bin/install.sh)
```

That's it. This can be put in any instructions, such as a README or someone's blog, since the logic is in the shell
script. Provided you download the script using https, the file has standard levels of authentication and encryption
protecting it from manipulation. We also sign the install with a GPG key, this way you can check if the downloaded
releases signature matches the public key of Dealerdirect.

```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys C4133165DF5EB4BAEABDADCACF1E7823C5339B59
curl -O https://raw.githubusercontent.com/DealerDirect/php-qa-tools/master/bin/install.sh
curl -O https://raw.githubusercontent.com/DealerDirect/php-qa-tools/master/bin/install.sh.sig
gpg --verify install.sh.sig
bash install.sh
```

This is obviously a shell script, if you're really concerned about the argument that it may contain nefarious
activities within, you can easily review it before you run it.

```bash
curl -O https://raw.githubusercontent.com/DealerDirect/php-qa-tools/master/bin/install.sh
less install.sh
bash instal.sh
```



If you already have a global Composer setup, you could include the tools manually, without the need for running
the shell script above.

```bash
composer global require "dealerdirect/qa-tools:*"
```

#### Per project installation

The other option is to install this on a per project basis.

Using Composer (preferred method):

```bash
composer require --dev "dealerdirect/qa-tools"
```

Or modify your `composer.json` to include `dealerdirect/qa-tools` in the `require-dev` sections:

```json
{
  "name": "acme/my-project",
  "require": {
    "…": "*"
  },
  "require-dev": {
    "dealerdirect/qa-tools": "*"
  }
}
```

## Contributing

This is an active open-source project. We are always open to people who want to use the code or contribute to it.

We've set up a separate document for our [contribution guidelines].

Thank you for being involved! :heart_eyes:

[contribution guidelines]: https://github.com/dealerdirect/php-qa-tools/blob/master/CONTRIBUTING.md

## Authors & Contributors

The original idea and setup of this repository is by [Franck Nijhof], employee @ Dealerdirect.

For a full list off all author and/or contributors, please check [this page].

[this page]: https://github.com/dealerdirect/php-qa-tools/graphs/contributors
[Franck Nijhof]: https://github.com/frenck

## Would you like to work @ Dealerdirect?

Dealerdirect is always on the looking for energetic and hard working developers and devops engineers.

Interested in working at Dealerdirect? Then please be sure to check out [our vacancies].

Did not find a matching vacancy? Just [get in touch]!

[WorkingAtDealerdirect.eu]

[our vacancies]: http://workingatdealerdirect.eu/?post_type=vacancy&s=&department=99
[get in touch]: http://workingatdealerdirect.eu/open-sollicitatie/
[WorkingAtDealerdirect.eu]: http://www.workingatdealerdirect.eu

## License

The MIT License (MIT)

Copyright (c) 2016 Dealerdirect B.V.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
