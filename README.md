# Dealerdirect: PHP Quality Assurance Tools

![Project Stage][project-stage-shield]
![Maintenance][maintenance-shield]
![Awesome][awesome-shield]
[![License][license-shield]](LICENSE.md)

[![Travis][travis-shield]][travis]
[![Dependency Status][versioneye-shield]][versioneye]
[![Latest Version on Packagist][packagist-version-shield]][packagist-version]
[![Packagist][packagist-shield]][packagist]

> _“If you don’t have time to do it right you must have time to do it over.”_

This is essentially a Composer meta package, creating a fast, easy and
convenient way of installing all PHP Quality Assurance tools.

## Contents

You'll get the following tools by depending on this package:

### Linters / Fixers

- **[JSON Lint][json-lint]**: JSON Lint for PHP
- **[PHP Coding Standards Fixer][phpcs-fixer]**: A tool to automatically fix PHP coding standards issues
- **[PHP Parallel Lint][php-parallel-lint]**: Check syntax of PHP files faster than serial check with fancier output
- **[PHP_CodeSniffer][phpcs]**: Detects violations of a defined set of coding standards

### Quality Assistance

- **[GrumPHP][grumphp]**: Githooks for PHP QA tooling
- **[PHP_Depend][pdepend]**: Software metrics for PHP
- **[PHPCPD][phpcpd]**: Copy/Paste Detector
- **[PHPLOC][phploc]**: Quickly measure the size of a PHP project
- **[PHPMD][phpmd]**: PHP Mess Detector
- **[PhpMetrics][phpmetrics]**: A static analysis tool for PHP
- **[SensioLabs Security Checker][security-checker]**: Checks for dependencies with known security vulnerabilities

### Test Related

- **[Behat][behat]**: BDD framework for PHP
- **[Codeception][codeception]**: Modern full-stack testing framework for PHP
- **[Mink][mink]**: PHP 5.3+ web browser emulator abstraction
- **[Ocular][ocular]**: CLI for uploading external code coverage data to Scrutinizer
- **[ParaTest][paratest]**: Parallel testing for PHPUnit
- **[PHPUnit][phpunit]**: Testing framework for PHP

### Other

Other packages that you'll get:

- **[Behat Mink][behat-mink]**: Mink extension for Behat
- **[Composer Versions Check][versions-check]**: Checks if packages are up to date to last major versions after update
- **[Deployer][deployer]**: Deployment tool for PHP
- **[Deployer Recipes][deployer-recipes]**: Third party recipes to integrate with Deployer
- **[Mink Goutte Driver][mink-goutte-driver]**: Goutte driver for Mink framework
- **[Mink Selenium2 Driver][mink-selenium2-driver]**: Selenium2 (WebDriver) driver for Mink framework
- **[Phing][phing]**: Phing is a PHP project build system or build tool based on ​Apache Ant
- **[PHP_CodeSniffer Composer Installer][phpcs-composer-installer]**: For installing PHP_CodeSniffer coding standards
- **[PHPCompatibility][phpcompatibility]**: PHP Compatibility checks for PHP_CodeSniffer
- **[Prestissimo][prestissimo]**: Composer parallel install plugin
- **[Tombstone Analyzer][tombstone-analyzer]**: Report generation for Tombstones

## Suggested

The following packages are suggested:

- **[ApiGen][apigen]**: Smart and Readable Documentation for your PHP project
- **[Mockery][mockery]**: A simple yet flexible PHP mock object framework
- **[PHP_CodeBrowser][php-codebrowser]**: A code browser that augments the code with information from various QA tools
- **[phpcov]**: Command-line frontend for the PHP_CodeCoverage library
- **[phpDocumentor][phpdoc]**: Documentation generator for PHP
- **[phpDox][phpdox]**: Documentation generator for PHP
- **[Sami][sami]**: An API documentation generator

## Usage

This is a simple metapackage which can be used in two different ways; globally installed or on a per project basis.

Both methods have their strengths (+) and weaknesses (-).

**Global installation**:

- \+ All tools are present anywhere on your system
- \+ Can be used on any codebase, even the ones that don't use Composer.
- \- You'll have to update manually, since it's not a project, versioning is not managed.

**Per project installation**:

- \+ Versioning (update/installation) is provided in the project
- \- Tools not available system wide. You'll need to run them from a specific path.

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

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We've set up a separate document for our [contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original idea and setup of this repository is by [Franck Nijhof][frenck], employee @ Dealerdirect.

For a full list off all author and/or contributors, check [the contributors page][contributors].

## Working @ Dealerdirect

Dealerdirect is always on the looking for energetic and hard working developers
and devops engineers.

Interested in working at Dealerdirect?
Then please be sure to check out [our vacancies][vacancies].

Did not find a matching vacancy? Just [get in touch][get-in-touch]!

[workingatdealerdirect.eu][workingatdealerdirecteu]

## License

The MIT License (MIT)

Copyright (c) 2016-2017 Dealerdirect B.V.

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

[apigen]: http://www.apigen.org
[awesome-shield]: https://img.shields.io/badge/awesome%3F-yes-brightgreen.svg
[behat-mink]: https://github.com/Behat/MinkExtension
[behat]: http://behat.org
[codeception]: http://codeception.com
[contributors]: https://github.com/dealerdirect/php-qa-tools/graphs/contributors
[deployer-recipes]: https://github.com/deployphp/recipes
[deployer]: https://deployer.org
[frenck]: https://github.com/frenck
[get-in-touch]: http://workingatdealerdirect.eu/open-sollicitatie/
[grumphp]: https://github.com/phpro/grumphp
[json-lint]: https://github.com/Seldaek/jsonlint
[license-shield]: https://img.shields.io/github/license/dealerdirect/php-qa-tools.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2017.svg
[mink-goutte-driver]: https://github.com/minkphp/MinkGoutteDriver
[mink-selenium2-driver]: https://github.com/minkphp/MinkSelenium2Driver
[mink]: http://mink.behat.org
[mockery]: https://github.com/padraic/mockery
[ocular]: https://github.com/scrutinizer-ci/ocular
[packagist-shield]: https://img.shields.io/packagist/dt/dealerdirect/qa-tools.svg
[packagist-version-shield]: https://img.shields.io/packagist/v/dealerdirect/qa-tools.svg
[packagist-version]: https://packagist.org/packages/dealerdirect/qa-tools
[packagist]: https://packagist.org/packages/dealerdirect/qa-tools
[paratest]: https://github.com/brianium/paratest
[pdepend]: https://github.com/pdepend/pdepend
[phing]:https://www.phing.info/
[php-codebrowser]: https://github.com/mayflower/PHP_CodeBrowser
[php-parallel-lint]: https://github.com/JakubOnderka/PHP-Parallel-Lint
[phpcompatibility]: https://github.com/wimg/PHPCompatibility
[phpcov]: https://github.com/sebastianbergmann/phpcov
[phpcpd]: https://github.com/sebastianbergmann/phpcpd
[phpcs-composer-installer]: https://github.com/DealerDirect/phpcodesniffer-composer-installer
[phpcs-fixer]: http://cs.sensiolabs.org
[phpcs]: https://github.com/squizlabs/PHP_CodeSniffer
[phpdoc]: https://www.phpdoc.org
[phpdox]: http://phpdox.de
[phploc]: https://github.com/sebastianbergmann/phploc
[phpmd]: https://phpmd.org
[phpmetrics]: http://www.phpmetrics.org
[phpunit]: https://phpunit.de
[prestissimo]: https://github.com/hirak/prestissimo
[project-stage-shield]: https://img.shields.io/badge/Project%20Stage-Development-yellowgreen.svg
[sami]: https://github.com/FriendsOfPHP/sami
[security-checker]: https://security.sensiolabs.org
[tombstone-analyzer]: https://github.com/scheb/tombstone-analyzer
[travis-shield]: https://img.shields.io/travis/DealerDirect/php-qa-tools.svg
[travis]: https://travis-ci.org/DealerDirect/php-qa-tools
[vacancies]: http://workingatdealerdirect.eu/?post_type=vacancy&s=&department=99
[versioneye-shield]: https://www.versioneye.com/user/projects/580939a4d65a77002f5eab70/badge.svg
[versioneye]: https://www.versioneye.com/user/projects/580939a4d65a77002f5eab70
[versions-check]: https://github.com/Soullivaneuh/composer-versions-check
[workingatdealerdirecteu]: http://www.workingatdealerdirect.eu
