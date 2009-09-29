RCrypt
======
RCrypt is a simple RSA encryption library for your Ruby scripts.  It aims at
being a no-frills encrypt-decrypt solution when that is all you actually need.

Installation
------------
    gem install qhoxie-rcrypt --source http://gems.github.com

Usage
-----
There are a few ways to set your keys:

    >> RCrypt.private_key_file "path/to/id_rsa"     # you can
    >> RCrypt.public_key_file "path/to/id_rsa.pub"  # specify the files
    >> RCrypt.generate_key_pair                     # or generate the keys in RCrypt
    => {:public => "...", :private => "..."}

Once the keys are set, you can encrypt and decrypt.

    >> ciphertext = RCrypt.encrypt "secret"
    => "xO0h20SZZ3US6BJGOyl0mnjF1FIVqax8=="
    >> RCrypt.decrypt ciphertext
    => "secret"

Comments/Suggestions/Requests
----------------------------
Email me: qhoxie on gmail.com

Copyright
---------
Copyright (c) 2009 Quin Hoxie. See LICENSE for details.
