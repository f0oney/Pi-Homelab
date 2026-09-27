When a Docker Compose file is ran, this pulls the latest image to use for installation of the container. However, once installed, the image itself will stay in that current version until it is explicitly updated. 

To do this manually, you will need to stop and delete the container, before using the pull command, and then starting up the container again. This is not practical, especially if you're not accessing the back-end of your server often.

To make this more efficient and ensuring we have the most up-to-date images, we can install a working bash script, which can be automatically triggered each day. Therefore, we won't have to do this manually.

We will be storing this script under `~/pihomelab/scripts`, and installing this from the creator's GitHub page found here: https://github.com/mag37/dockcheck

Under your desired location, run the following curl command to install the script:

```bash
curl -L https://raw.githubusercontent.com/mag37/dockcheck/main/dockcheck.sh -o ~/pihomelab/scripts/dockcheck.sh
```

## Running the script
Once installed, confirm this is working by running it's help command built into the script:

```bash
./dockcheck.sh -h
```

This should spit out it's various functions. To test that this script is indeed working, and will pull and automatically re-run your docker containers, we can simply call it:

```
./dockcheck.sh
```

As it's our first time running the script, this will prompt you to install `regctl`. This is a Docker and OCI Registry Client, which is used for this script. Simply enter `y` to confirm it's installation.

Leave this to run. If there are available image updates, we can spot it's progress. This will outline which images are being pulled, and the process of re-running it's containers.

## Crontab Setup
If all works, we can then add this to our Crontab setup. First, make sure you're logged in as root, via `sudo su`. We can then run the below to enter Crontab's configuration:

```bash
Crontab -e
```

Inside of this file, we can add the following:

```bash
0 2 * * * /home/user/pihomelab/scripts/dockcheck.sh
```

These parameters state that the script will be called everyday, at 2AM. We can use the following website to ensure the correct parameters are used for our specified schedules: https://crontab.guru/#0_2_*_*_*

Save the file.

