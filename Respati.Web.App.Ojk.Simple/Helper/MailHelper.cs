using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;
using System.Net.Mail;
using System.Web.UI;

namespace Respati.Web.App.Ojk.Simple.Helper
{
    public class MailHelper
    {
        private readonly string _mailSender;
        private readonly int _mailPort;
        private readonly string _mailHost;
        private readonly string _mailUsername;
        private readonly string _mailPassword;
        private readonly int _mailTimeout;

        private SmtpClient _client;
        private MailMessage _mail;

        public MailHelper()
        {

            _mailPort = int.Parse(ConfigurationManager.AppSettings["mail_port"].ToString());
            _mailHost = ConfigurationManager.AppSettings["mail_host"].ToString();
            _mailUsername = ConfigurationManager.AppSettings["mail_username"].ToString();
            _mailPassword = ConfigurationManager.AppSettings["mail_password"].ToString();
            _mailTimeout = int.Parse(ConfigurationManager.AppSettings["mail_timeout"].ToString());
        }

        public void SendEmail(string mailTo, string mailRecipientCc, string mailSubject, string mailMessage, bool isHtml = false)
        {
            int status = 0;
            _client = new SmtpClient
           {
               Port = _mailPort,
               Credentials = new NetworkCredential(_mailUsername, _mailPassword),
               EnableSsl = true,
               Host = _mailHost,
               Timeout = _mailTimeout
           };
            _mail = new MailMessage(_mailUsername, mailTo)
           {
               Subject = mailSubject,
               Body = mailMessage,

           };

            try
            {

                _mail.IsBodyHtml = isHtml;
                if (!string.IsNullOrEmpty(mailRecipientCc))
                {
                    List<string> listcc = mailRecipientCc.Split(';').ToList();
                    listcc.ForEach(x => _mail.CC.Add(new MailAddress(x)));
                }
                _client.Send(_mail);
                status = 1;
            }
            catch (Exception ex)
            {
                status = -1;

            }
            finally
            {
                Helper.InsertMailHistory(mailTo, mailSubject, mailMessage, HttpContext.Current.User.Identity.Name,
                status);
                
                _mail.Dispose();
                _client.Dispose();
            }


        }

    }
}