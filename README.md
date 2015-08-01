# packer-templates

Packer templates and utilities for a devops workflow oriented towards composable system images.

The general idea is to not use a given packer build as a complete system image build, but rather
to think of it as composable function to perform a simple transformation in a chain.  These simple
builds are much easier to debug than more complex builds.

While a complete build does take a little longer with intermediate steps, normal development
iteration goes much faster as you're only ever iterating over a simple, quick build.  In practice,
this seems to make upgrades much less painful to work through.

This method of composability also allows reuse of the intermediate outputs between separate end
outputs.  For example, I have an intermediate output to build a system image with all dependencies
for a webapp.  I then output process that system image through separate output stages for local Vagrant
development and production, where the only real differences are the final output format and removing
the vagrant account for production.  The final builds in the chain run very quickly.  Since the majority
of work is shared by their common ancestor and only performed once, we nearly cut overall build time in
half.


# Credits

Every attempt has been made to give appropriate and correct credit where it's due on scripts
and configs borrowed from other sources.  Please let me know if better attribution is possible.
