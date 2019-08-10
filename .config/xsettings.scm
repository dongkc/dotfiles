(use-modules (guix packages)
	     (guix download)
	     (gnu packages pkg-config)
	     (gnu packages xorg)
	     (guix build-system scons)
	     (guix licenses))

  (package
    (name "xsettingsd")
    (version "1.0.0")
    (source (origin
	      (method url-fetch)
	      (uri (string-append "https://github.com/derat/xsettingsd/archive/v" version
				  ".tar.gz"))
	      (sha256
	       (base32
            "0xx9ifbh5z25wpjcyj6mchs5wirw27fydarfvh241ycsk5dqj2zy"))))
    (build-system scons-build-system)
    (arguments
      `(#:tests? #f
	#:phases
	(modify-phases %standard-phases
		       (add-after 'unpack 'patch-scons
				  (lambda _
				    (substitute* "SConstruct"
						 (("Environment\\(")
						  "Environment(ENV = os.environ,"))
						 #t))
		       (replace 'install
				(lambda* (#:key outputs #:allow-other-keys)
					 (let* ((out (assoc-ref outputs "out")))
					   (install-file "xsettingsd"
							 (string-append out "/bin"))
					   (install-file "dump_xsettings"
							 (string-append out "/bin"))
					   #t))))))
    (native-inputs
      `(("pkg-config" ,pkg-config)
	("libx11" ,libx11)))
    (synopsis "Provides settings to X11 applications via the XSETTINGS specification")
    (description
     "Provides settings to X11 applications via the XSETTINGS specification")
    (home-page "https://github.com/derat/xsettingsd")
    (license gpl3+))
