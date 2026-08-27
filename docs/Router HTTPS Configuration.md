# Router HTTPS Configuration

The router HTTPS will need to be setup differently, as opposed to using Nginx. For my Router, I will be using ASUS' in-built Local Config. This will provide us with a certificate, and also setting a HTTPS port against it for access. 

-----------------------------------------------

### Router Settings

To enable this, navigate to Administration > System, and scroll down to Local Access Config.

Under the Authentication Method, set this to HTTPS. This will bring up additional fields, allowing us to add the HTTPS port, as well as downloading the certificate.

![[Pasted image 20260820192305.png]]

By default, this can be set to `8443`. 

Install the certificate by clicking on **Export Root Certificate**. We can then install the certificate and add to our **Trusted Root Certification Authorities**.

### Adding to Trusted Root Certification Authorities

1. Double-click the `.crt` file that was downloaded, and press Install Certificate
2. Select **Current User**, under **Store Location**. Press **Next**.
3. Select **Place all certificates in the following store**, and press **Browse**. Double-click **Trusted Root Certification Authorities**, and press **OK**.
4. Press **Next** and **Finish**.
5. Confirm installation, by press **Yes**.

### Adding Certificate Snap-ons

1. Launch **MMC**
2. Choose **File** > **Add/Remove Snap-ins**
3. Choose **Certificates**, then choose **Add**
4. Choose **My user account**
5. Choose **Add** again, but this time select **Computer Account**
6. Press **OK**
7. Under **Certificates - Current User**, navigate to **Trusted Root Certification Authorities** > **Certificates**
8. Find the installed certificate, highlight, and press **Copy**
9. Then, navigate to **Certificates (Local Computer)** > **Trusted Root Certification Authorities** > **Certificates**
10. Press **Paste**

We can confirm that this loads via HTTPS, by entering the router IP and port 8443 (or port you have used).
