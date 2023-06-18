# dm-delay-root

Delay injection into root device using device mapper.

Using [device mapper](https://docs.kernel.org/admin-guide/device-mapper/index.html), 
we can inject arbitrary delay at requesting I/O for block devices, 
so we can simulate slowing down disks quite realistically, even from the kernel's perspective.

[ddi](https://github.com/kawamuray/ddi) is a tool to setup a device mapper to inject
dynamically controllable delay easily.

However, to inject delay into root device, we need to setup the device mapper before the root device is mounted.

This can be done by using initramfs.

This repository demonstrates how to setup initramfs to inject delay into root device.

## Usage with lima on macOS

### Setup

- Install ansible
  * ```
    $ brew install ansible
    ```
- Start lima instance
  * ```
    $ limactl start --name=$LIMA_INSTANCE_NAME template://default
    ```
- Create inventory
  * ```sh
    $ ./create-lima-inventory.sh $LIMA_INSTANCE_NAME
    ```
- Run ansible playbook
  * ```sh
    $ ansible-playbook -i hosts site.yml
    ```
- Reboot the instance
  * ```sh
    $ limactl stop $LIMA_INSTANCE_NAME
    $ limactl start $LIMA_INSTANCE_NAME
    ```

### Inject delays

Then you can inject arbitrary delays into the root device using sysfs.

```sh
$ limactl shell $LIMA_INSTANCE_NAME
lima:$ echo 500 | sudo tee /sys/fs/ddi/252\:1/read_delay
```
