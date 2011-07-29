Name:			beacon
Version:		0.5
Release:		8%{?dist}
Summary:		WYSIWYG editor for docbook xml

Group:			Applications/Editors
License:		GPLv3+
URL:			http://fedoraproject.org/wiki/DocBook_Editor
Source0:		%{name}-%{version}.tar.gz
BuildRoot:		%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:		noarch
Requires:		php, httpd, php-xml, mysql-server, mysql, php-mysql

%description
Beacon is an XSLT based plug-able WYSIWYG editor for DocBook xml. It
is intended to serve as an easy to use tool which will attract new
contributors who would otherwise be discouraged by the steep learning
curve involved with DocBook and will also provide a convenient
alternative to those who are old-timers. More information is available
at https://fedoraproject.org/wiki/DocBook_Editor_Documentation and
https://fedoraproject.org/wiki/DocBook_Editor_Feature.

%prep
%setup -q


%build
# Empty build

%install
rm -rf $RPM_BUILD_ROOT
make install prefix=$RPM_BUILD_ROOT/usr sysconfdir=$RPM_BUILD_ROOT/etc/

#mkdir -p $RPM_BUILD_ROOT/%{_datadir}/beacon
#cp -rp beacon php $RPM_BUILD_ROOT/%{_datadir}/beacon/
#mkdir -p $RPM_BUILD_ROOT/%{_sysconfdir}/httpd/conf.d/
#cp -p  httpd-beacon.conf $RPM_BUILD_ROOT/%{_sysconfdir}/httpd/conf.d/

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc docs/* LICENSE README TODO
%{_datadir}/beacon/*
%attr(0700,apache,apache)

%config(noreplace) %{_sysconfdir}/httpd/conf.d/httpd-beacon.conf
%config(noreplace) %{_datadir}/beacon/php/settings.php


%changelog

* Fri Jul 29 2011 Satya Komaragiri <satyak@fedoraproject.org> 0.5-8
- Merged the login and register popup to main page. (https://github.com/satya/beacon/issues/4
- Added ability to add new users anytime. (https://github.com/satya/beacon/issues/1)

* Wed Jul 27 2011 P J P <pj.pandit@yahoo.co.in> 0.5.7
- changed to load documents from internet URLs.

* Fri Jun 24 2011 P J P <pj.pandit@yahoo.co.in> 0.5-6
- updated to load external files - Bug=704375.
- redirects to index.php, in case of an error: expired session etc.

* Sat Jun 18 2011 P J P <pj.pandit@yahoo.co.in> 0.5-5
- Updated source to include upstream bug fixes.
- included httpd-beacon.conf into the source tarball.

* Tue May 10 2011 Satya Komaragiri <satyak@fedoraproject.org> 0.5-4
- Added dependency on php-mysql.
- Made mysql login as default.
- Handled file names with spaces.

* Wed Aug 24 2009 Satya Komaragiri <satyak@fedoraproject.org> 0.5-3
- Improved description.
- Reverted back to requiring httpd.

* Wed Aug 24 2009 Satya Komaragiri <satyak@fedoraproject.org> 0.5-2
- Changed requires to webserver from httpd
- Added beacon/php/settings.php to the config section.
- Removed /var/tmp as we are using mysql now.
- Added more documentation and moved README.fedora inside the tarball.

* Wed Aug 12 2009 Satya Komaragiri <satyak@fedoraproject.org> 0.5-1
- Initial version
