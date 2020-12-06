def get_steps_workaround():
	return [
		"cp -v tar /usr/local/bin/tar",
		"dpkg-architecture",
		"dpkg --fsys-tarfile /drone/src/*.deb | (cd / ; tar xf - )",
		"date -R",
		"ls .",
		"apt update",
		"apt install --yes strace",
		"strace apt update 2>&1 | grep -i syscall",
	]

def main(context):
	return [
		{
			"kind" : "pipeline",
			"name" : "%s-%s" % (image, architecture),
			"type" : "docker",
			"platform" : {
				"os" : "linux",
				"arch" : architecture,
			},
			"steps" : [
				{
					"name" : "test",
					"image" : image if not image == "workaround" else "quay.io/hybrismobian/build-essential:bullseye-armhf",
					"commands" : get_steps_workaround() if image == "workaround" else [
						"uname -a",
						"date -R",
						"apt update",
					]
				},
			],
		}
		for image, architecture in [
#			("debian:buster", "arm64"),
#			("debian:buster", "arm"),
#			("debian:bullseye", "arm64"),
#			("debian:bullseye", "arm"),
#			("ubuntu:bionic", "arm64"),
#			("ubuntu:bionic", "arm"),
#			("ubuntu:focal", "arm64"),
#			("ubuntu:focal", "arm"),
			("workaround", "arm"),
		]
	]
