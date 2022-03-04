## <a name="run"></a> How to Run Bitwarden Directory Connector

```bash
# These credentials are taken from the bwdc documentation.  Change them.
BW_CLIENTID="organization.b5351047-89b6-820f-ad21016b6222"
BW_CLIENTSECRET="yUMB4trbqV1bavhEHGqbuGpz4AlHm9"
BW_ORG_ID=`sed 's/^organization\.//' <<< ${BW_CLIENTID}`
BW_JUMPCLOUD_ORG_ID='YOUR_ORG_ID'
BW_JUMPCLOUD_BIND_USER='LDAP_BIND_USER'
BW_JUMPCLOUD_BIND_PASS='PLAINTEXT_PASSWORD'

# Here we use the config_examples directory for the bwdc config.
# data.json is in the .gitignore
CONFIG_DIR=`realpath ./config_examples`
cp ${CONFIG_DIR}/jumpcloud.json ${CONFIG_DIR}/data.json

# Replace values in bwdc config
sed "s/BITWARDEN_ORG_ID/${BW_ORG_ID}/" -i ${CONFIG_DIR}/data.json
sed "s/LDAP_BIND_PASSWORD/${BW_JUMPCLOUD_BIND_PASS}/" -i ${CONFIG_DIR}/data.json
sed "s/LDAP_BIND_USERNAME/${BW_JUMPCLOUD_BIND_USER}/" -i ${CONFIG_DIR}/data.json
sed "s/o=JUMPCLOUD_ORG_ID/${BW_JUMPCLOUD_ORG_ID}/" -i ${CONFIG_DIR}/data.json

docker pull estenrye/bwdc:latest

docker run \
  -v $CONFIG_DIR:/home/bwdc/.config/Bitwarden\ Directory\ Connector \
  -e BW_CLIENTID=$BW_CLIENTID \
  -e BW_CLIENTSECRET=$BW_CLIENTSECRET
  estenrye/bwdc:latest login

docker run \
  -v $CONFIG_DIR:/home/bwdc/.config/Bitwarden\ Directory\ Connector \
  estenrye/bwdc:latest test
```

## <a name="commits"></a> Git Commit Guidelines

We have very precise rules over how our git commit messages can be formatted.  This leads to **more
readable messages** that are easy to follow when looking through the **project history**.  But also,
we use the git commit messages to **generate the AngularJS change log**.

The commit message formatting can be added using a typical git workflow or through the use of a CLI
wizard ([Commitizen](https://github.com/commitizen/cz-cli)). To use the wizard, run `yarn run commit`
in your terminal after staging your changes in git.

### Commit Message Format
Each commit message consists of a **header**, a **body** and a **footer**.  The header has a special
format that includes a **type**, a **scope** and a **subject**:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

The **header** is mandatory and the **scope** of the header is optional.

Any line of the commit message cannot be longer than 100 characters! This allows the message to be easier
to read on GitHub as well as in various git tools.

### Revert
If the commit reverts a previous commit, it should begin with `revert: `, followed by the header
of the reverted commit.
In the body it should say: `This reverts commit <hash>.`, where the hash is the SHA of the commit
being reverted.

### Type
Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, formatting, missing
  semi-colons, etc)
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing or correcting existing tests
* **chore**: Changes to the build process or auxiliary tools and libraries such as documentation
  generation

### Scope
The scope could be anything specifying place of the commit change. For example `$location`,
`$browser`, `$compile`, `$rootScope`, `ngHref`, `ngClick`, `ngView`, etc...

You can use `*` when the change affects more than a single scope.

### Subject
The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end

### Body
Just as in the **subject**, use the imperative, present tense: "change" not "changed" nor "changes".
The body should include the motivation for the change and contrast this with previous behavior.

### Footer
The footer should contain any information about **Breaking Changes** and is also the place to
[reference GitHub issues that this commit closes][closing-issues].

**Breaking Changes** should start with the word `BREAKING CHANGE:` with a space or two newlines.
The rest of the commit message is then used for this.

A detailed explanation can be found in this [document][commit-message-format].