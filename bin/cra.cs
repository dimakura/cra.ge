using System;
using System.Xml;
using System.Security.Cryptography.X509Certificates;
using System.Security.Cryptography;

using System.Security.Cryptography.Xml;
using Mono.Security;

class Program
{
	static void Main(string[] args) {
		if (args.Length != 4) {
			Console.WriteLine("Usage: cra.exe cert-file cert-password input-path output-path");
			return;
		}

		String certFile = args[0];
		String password = args[1];
		String input    = args[2];
		String output   = args[3];

		X509Certificate2 cert = new X509Certificate2(certFile, password, X509KeyStorageFlags.Exportable | X509KeyStorageFlags.PersistKeySet);

		XmlDocument xmlDoc = new XmlDocument();
		xmlDoc.Load(input);

		var XmlToSign = new XmlDocument();
  	XmlToSign.LoadXml(xmlDoc.DocumentElement["Body"].OuterXml);

		SignedXml signedXml = new SignedXml(XmlToSign);
		signedXml.SigningKey = cert.PrivateKey;

		Reference reference = new Reference();
		reference.Uri = "";

    XmlDsigEnvelopedSignatureTransform env = new XmlDsigEnvelopedSignatureTransform();
    reference.AddTransform(env);

		signedXml.AddReference(reference);
		signedXml.ComputeSignature();
		XmlElement xmlDigitalSignature = signedXml.GetXml();
		xmlDoc.DocumentElement["Body"].AppendChild(xmlDoc.ImportNode(xmlDigitalSignature, true));
		xmlDoc.Save(output);
	}
}
