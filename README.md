# beats4pi

Docker image to build elastic/beats for Raspberry Pi

**NEW 2022** Changes to work more robust without mage and newer golang version.

Original: https://github.com/andig/beats4pi

## Customizing

The image has a couple of ENV vars that can be used for customizing what and how to build:

  - `GOARCH=arm` - the target architecture, arm for RaspberryPi
  - `GOARM=7` - ARM architecture version - 7 for RasperryPi 3
  - `BEATS=filebeat,metricbeat` - comma-separated list of beats to compile
  - `BEATS_VERSION=8.2.0` - version to compile

## Building elastic beats

This command will output the build result in the current folder:

    docker build --tag="beats4pi" .
    docker run -v $(pwd):/build -e BEATS_VERSION=8.2.0 beats4pi
    
## Other

To test the build script without re-downloading elastic/beats you can clone it once and then map the cloned folder into the images' `GOPATH`:

    git clone https://github.com/elastic/beats
    docker run -v $(pwd)/beats:/go/src/github.com/elastic/beats beats4pi

See https://gist.github.com/andig/650915e02b18cfe38de6516686977bca for an approach how to manually build beats with the various configurations required natively on a RaspberryPi 3.

See https://gist.github.com/joariasl/153a1d5253dc938429e2e5936339959a for cross compilation and installation with systemd on armv7 / armhf for e. g. Revolution Pi.
