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
					"image" : image,
					"commands" : [
						"uname -a",
						"date -R",
						"apt update",
					]
				},
			],
		}
		for image, architecture in [
			("debian:buster", "arm64"),
			("debian:buster", "arm"),
			("debian:bullseye", "arm64"),
			("debian:bullseye", "arm"),
			("ubuntu:bionic", "arm64"),
			("ubuntu:bionic", "arm"),
			("ubuntu:focal", "arm64"),
			("ubuntu:focal", "arm"),
		]
	]
