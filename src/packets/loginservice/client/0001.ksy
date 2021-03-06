#pragma.examples loginservice/client 0001
#pragma.parseAs LoginserviceClientPacket
---
meta:
  id: loginservice_client_0001_login
  title: LoginService Client Login Packet
  encoding: ASCII
  endian: le
  imports:
    - ../../common/pstring

doc: |
  This packet is sent by the PangYa client when the user clicks the 'Login'
  button. Upon clicking login, the client opens a TCP connection to the
  LoginService, performs the protocol handshake, sends this message, and then
  awaits a reply from the server.
  
  In `hsreina/pangya-server`, the packet ID is `TCLPID.PLAYER_LOGIN`.

  **See Also**: [LoginService Server 0x0001 Login Packet](/packets/loginservice/server/0001.ksy)

seq:
  - id: username
    type: pstring
    doc: |
      Username, as entered by the user in the Login dialog.

  - id: password
    type: pstring
    doc: |
      Password, as entered by the user in the Login dialog. In some releases,
      such as the TH release, this is sent as plaintext, whereas in others, it
      is sent as an MD5 hash.

  - id: padding
    size-eos: true
    doc: |
      A few padding bytes. In the US release, this is 17 bytes of zeros. In
      the TH release, this is 18 bytes, and is a static pattern on every
      login. It is unclear what the function of this is.

      Note that the padding does not improve the obfuscation. In the US
      release, because this is zeroed, the last four characters of the MD5 sum
      will appear unobfuscated in the ciphertext, because they will be XOR'd
      with the zeros.

      The server does not seem to actually read these bytes and any pattern of
      bits will be accepted.
