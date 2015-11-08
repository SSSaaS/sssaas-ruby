# sssaas-ruby
API Library for [SSSaaS](http://sssaas.com)

    Copyright (C) 2015 Alexander Scheel, Joel May, Matthew Burket  
    See Contributors.md for a complete list of contributors.  
    Licensed under the MIT License.  

## Usage
Note: this is the API library; for an implementation of SSS in Ruby, look [here](https://github.com/SSSAAS/sssaas-ruby).

    SSSaaS::get_secret(serveruris, tokens, secrets, timeout=300)
        - combines and retrieves secret from a collection of remote URIs;  
          throws exception on request failure

For more detailed documentation, check out docs/sssaas.md

## Contributing
We welcome pull requests, issues, security advice on this library, or other
contributions you feel are necessary. Feel free to open an issue to discuss
any questions you have about this library.

The reference implementation for this cross-language project was written in Go.
Please consult the golang library [here](https://github.com/SSSAAS/sssaas-golang).

For security issues, send a GPG-encrypted email to
<alexander.m.scheel@gmail.com> with public key
[0xBDC5F518A973035E](https://pgp.mit.edu/pks/lookup?op=vindex&search=0xBDC5F518A973035E).
