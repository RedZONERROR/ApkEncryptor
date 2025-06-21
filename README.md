# APKEncryptor

**Comprehensive toolkit for protecting Android applications through resource encryption and VIP licence management.**

This repository is an actively maintained fork of the original work by [FlyingYu-Z](https://github.com/FlyingYu-Z/ApkEncryptor). All credit for the groundbreaking idea and first implementation belongs to the original author. This fork focuses on clearer documentation, build automation and minor bug-fixes; no functional changes are introduced without attribution.

![Screenshot](https://github.com/redzonerror/ApkEncryptor/blob/main/screenshot.png)

## Modules at a glance

| Module | Purpose |
|--------|---------|
| `APKEncryptor-Android` | End-user client that performs local APK encryption and communicates with the server |
| `APKEncryptor-Server` | Java TCP service (default **6666**) that validates VIP status and stores data in MySQL |
| `APKEncryptor-Tools` | Command-line helpers that encrypt assets and patch the SubApplication shell |
| `KeyCreateor-Andtoid` | Android admin app used to generate VIP licence keys |
| `SubApplication` | Lightweight shell APK dynamically loaded by the client |

## Getting started

A complete, step-by-step installation guide is available in [`SYSTEM_SETUP.md`](./SYSTEM_SETUP.md). Each sub-project also ships with its own `README.md` detailing prerequisites and build commands.

## Credits

* Original author: **FlyingYu-Z**  
* Current maintainer of this fork: **redzonerror**

---

## License


> Copyright (c) <year> <copyright holders>
> 
> "Anti 996" License Version 1.0 (Draft)
> 
> Permission is hereby granted to any individual or legal entity
> obtaining a copy of this licensed work (including the source code,
> documentation and/or related items, hereinafter collectively referred
> to as the "licensed work"), free of charge, to deal with the licensed
> work for any purpose, including without limitation, the rights to use,
> reproduce, modify, prepare derivative works of, distribute, publish
> and sublicense the licensed work, subject to the following conditions:
> 
> 1. The individual or the legal entity must conspicuously display,
> without modification, this License and the notice on each redistributed
> or derivative copy of the Licensed Work.
> 
> 2. The individual or the legal entity must strictly comply with all
> applicable laws, regulations, rules and standards of the jurisdiction
> relating to labor and employment where the individual is physically
> located or where the individual was born or naturalized; or where the
> legal entity is registered or is operating (whichever is stricter). In
> case that the jurisdiction has no such laws, regulations, rules and
> standards or its laws, regulations, rules and standards are
> unenforceable, the individual or the legal entity are required to
> comply with Core International Labor Standards.
> 
> 3. The individual or the legal entity shall not induce, suggest or force
> its employee(s), whether full-time or part-time, or its independent
> contractor(s), in any methods, to agree in oral or written form, to
> directly or indirectly restrict, weaken or relinquish his or her
> rights or remedies under such laws, regulations, rules and standards
> relating to labor and employment as mentioned above, no matter whether
> such written or oral agreements are enforceable under the laws of the
> said jurisdiction, nor shall such individual or the legal entity
> limit, in any methods, the rights of its employee(s) or independent
> contractor(s) from reporting or complaining to the copyright holder or
> relevant authorities monitoring the compliance of the license about
> its violation(s) of the said license.
> 
> THE LICENSED WORK IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
> IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM,
> DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE, ARISING FROM, OUT OF OR IN ANY WAY CONNECTION WITH THE
> LICENSED WORK OR THE USE OR OTHER DEALINGS IN THE LICENSED WORK.
> 