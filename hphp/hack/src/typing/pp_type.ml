(*
 * Copyright (c) 2015, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the "hack" directory of this source tree.
 *
 *)

open Hh_prelude
open Typing_defs

(* Pretty-printing for the Typing_defs.ty data structure.
 *
 * This was (largely) automatically generated by the ppx_deriving show plugin.
 * Since that plugin does not support GADTs, we must add locally abstract types
 * to its output and manually maintain it here.
 *
 * This differs from Typing_print in that it is intended for pretty-printing the
 * Typing_defs.ty data structure and other data structures containing a ty, in
 * the typical format used for OCaml data structures. Typing_print prints
 * human-readable (for error and IDE display) and JSON (for tooling)
 * representations of types.
 *)

let rec pp_ty : type a. Format.formatter -> a ty -> unit =
 fun fmt t ->
  let (a0, a1) = deref t in
  Format.fprintf fmt "(@[";
  Reason.pp fmt a0;
  Format.fprintf fmt ",@ ";
  pp_ty_ fmt a1;
  Format.fprintf fmt "@])"

and show_ty : type a. a ty -> string = (fun x -> Format.asprintf "%a" pp_ty x)

and pp_shape_field_type : type a. Format.formatter -> a shape_field_type -> unit
    =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";
  Format.fprintf fmt "@[%s =@ " "sft_optional";
  Format.fprintf fmt "%B" x.sft_optional;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";
  Format.fprintf fmt "@[%s =@ " "sft_ty";
  pp_ty fmt x.sft_ty;
  Format.fprintf fmt "@]";
  Format.fprintf fmt "@ }@]"

and show_shape_field_type : type a. a shape_field_type -> string =
 (fun x -> Format.asprintf "%a" pp_shape_field_type x)

and pp_ty_ : type a. Format.formatter -> a ty_ -> unit =
 fun fmt ty ->
  match ty with
  | Tany _ -> Format.pp_print_string fmt "Tany"
  | Terr -> Format.pp_print_string fmt "Terr"
  | Tthis -> Format.pp_print_string fmt "Tthis"
  | Tmixed -> Format.pp_print_string fmt "Tmixed"
  | Tdynamic -> Format.pp_print_string fmt "Tdynamic"
  | Tnonnull -> Format.pp_print_string fmt "Tnonnull"
  | Tapply (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tapply (@,";
    let () = Aast.pp_sid fmt a0 in
    Format.fprintf fmt ",@ ";
    Format.fprintf fmt "@[<2>[";
    ignore
      (List.fold_left
         ~f:(fun sep x ->
           if sep then Format.fprintf fmt ";@ ";
           pp_ty fmt x;
           true)
         ~init:false
         a1);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt "@,))@]"
  | Tgeneric (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tgeneric (@,";
    Format.fprintf fmt "%S" a0;
    Format.fprintf fmt ",@ ";
    pp_ty_list fmt a1;
    Format.fprintf fmt "@,)@]"
  | Tunapplied_alias a0 ->
    Format.fprintf fmt "(@[<2>Tunappliedalias@ ";
    Format.fprintf fmt "%S" a0;
    Format.fprintf fmt "@])"
  | Taccess a0 ->
    Format.fprintf fmt "(@[<2>Taccess@ ";
    pp_taccess_type fmt a0;
    Format.fprintf fmt "@])"
  | Tarray (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tarray (@,";
    (match a0 with
    | None -> Format.pp_print_string fmt "None"
    | Some x ->
      Format.pp_print_string fmt "(Some ";
      pp_ty fmt x;
      Format.pp_print_string fmt ")");
    Format.fprintf fmt ",@ ";
    (match a1 with
    | None -> Format.pp_print_string fmt "None"
    | Some x ->
      Format.pp_print_string fmt "(Some ";
      pp_ty fmt x;
      Format.pp_print_string fmt ")");
    Format.fprintf fmt "@,))@]"
  | Tdarray (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tdarray (@,";
    pp_ty fmt a0;
    Format.fprintf fmt ",@ ";
    pp_ty fmt a1;
    Format.fprintf fmt "@,))@]"
  | Tvarray a0 ->
    Format.fprintf fmt "(@[<2>Tvarray@ ";
    pp_ty fmt a0;
    Format.fprintf fmt "@])"
  | Tvarray_or_darray (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tvarray_or_darray@ ";
    pp_ty fmt a0;
    Format.fprintf fmt ",@ ";
    pp_ty fmt a1;
    Format.fprintf fmt "@])"
  | Toption a0 ->
    Format.fprintf fmt "(@[<2>Toption@ ";
    pp_ty fmt a0;
    Format.fprintf fmt "@])"
  | Tlike a0 ->
    Format.fprintf fmt "(@[<2>Tlike@ ";
    pp_ty fmt a0;
    Format.fprintf fmt "@])"
  | Tprim a0 ->
    Format.fprintf fmt "(@[<2>Tprim@ ";
    Aast.pp_tprim fmt a0;
    Format.fprintf fmt "@])"
  | Tfun a0 ->
    Format.fprintf fmt "(@[<2>Tfun@ ";
    pp_fun_type fmt a0;
    Format.fprintf fmt "@])"
  | Ttuple a0 ->
    Format.fprintf fmt "(@[<2>Ttuple@ ";
    Format.fprintf fmt "@[<2>[";
    ignore
      (List.fold_left
         ~f:(fun sep x ->
           if sep then Format.fprintf fmt ";@ ";
           pp_ty fmt x;
           true)
         ~init:false
         a0);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt "@])"
  | Tshape (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tshape (@,";
    pp_shape_kind fmt a0;
    Format.fprintf fmt ",@ ";
    Nast.ShapeMap.pp pp_shape_field_type fmt a1;
    Format.fprintf fmt "@,))@]"
  | Tvar a0 ->
    Format.fprintf fmt "(@[<2>Tvar@ ";
    Ident.pp fmt a0;
    Format.fprintf fmt "@])"
  | Tnewtype (a0, a1, a2) ->
    Format.fprintf fmt "(@[<2>Tnewtype (@,";
    Format.fprintf fmt "%S" a0;
    Format.fprintf fmt ",@ ";
    Format.fprintf fmt "@[<2>[";
    ignore
      (List.fold_left
         ~f:(fun sep x ->
           if sep then Format.fprintf fmt ";@ ";
           pp_ty fmt x;
           true)
         ~init:false
         a1);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt ",@ ";
    pp_ty fmt a2;
    Format.fprintf fmt "@,))@]"
  | Tdependent (a0, a1) ->
    Format.fprintf fmt "(@[<2>Tdependent@ ";
    pp_dependent_type fmt a0;
    Format.fprintf fmt ",@ ";
    pp_ty fmt a1;
    Format.fprintf fmt "@])"
  | Tunion tyl ->
    Format.fprintf fmt "(@[<2>Tunion@ ";
    pp_ty_list fmt tyl
  | Tintersection tyl ->
    Format.fprintf fmt "(@[<2>Tintersection@ ";
    pp_ty_list fmt tyl
  | Tobject -> Format.pp_print_string fmt "Tobject"
  | Tclass (a0, _a2, a1) ->
    Format.fprintf fmt "(@[<2>Tclass (@,";
    Aast.pp_sid fmt a0;
    Format.fprintf fmt ",@ ";
    Format.fprintf fmt "@[<2>[";
    ignore
      (List.fold_left
         ~f:(fun sep x ->
           if sep then Format.fprintf fmt ";@ ";
           pp_ty fmt x;
           true)
         ~init:false
         a1);
    Format.fprintf fmt "@,]@]";
    Format.fprintf fmt "@,))@]"
  | Tpu (base, enum) ->
    Format.fprintf fmt "(@[<2>Tpu (%a@,,%a)@])" pp_ty base Aast.pp_sid enum;
    Format.fprintf fmt "@])"
  | Tpu_access (base, sid) ->
    Format.fprintf fmt "(@[<2>Tpu_access (@,";
    pp_ty fmt base;
    Format.fprintf fmt ",@ ";
    Aast.pp_sid fmt sid;
    Format.fprintf fmt "@,))@]"
  | Tpu_type_access (member, tyname) ->
    Format.fprintf
      fmt
      "(@[<2>Tpu_type_access (%a@,,%a)@])"
      Aast.pp_sid
      member
      Aast.pp_sid
      tyname;
    Format.fprintf fmt "@])"

and pp_ty_list : type a. Format.formatter -> a ty list -> unit =
 fun fmt tyl ->
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_ty fmt x;
         true)
       ~init:false
       tyl);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@])"

and show_ty_ : type a. a ty_ -> string = (fun x -> Format.asprintf "%a" pp_ty_ x)

and pp_dependent_type : Format.formatter -> dependent_type -> unit =
 fun fmt a0 ->
  Format.fprintf fmt "(@[";
  match a0 with
  | DTthis -> Format.pp_print_string fmt "DTthis"
  | DTexpr x ->
    Format.fprintf fmt "DTexpr (@[<hov>";
    Ident.pp fmt x;
    Format.fprintf fmt "@])"

and show_dependent_type : dependent_type -> string =
 (fun x -> Format.asprintf "%a" pp_dependent_type x)

and pp_taccess_type : Format.formatter -> taccess_type -> unit =
 fun fmt (a0, a1) ->
  Format.fprintf fmt "(@[";
  pp_ty fmt a0;
  Format.fprintf fmt ",@ ";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         Aast.pp_sid fmt x;
         true)
       ~init:false
       a1);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@])"

and show_taccess_type : taccess_type -> string =
 (fun x -> Format.asprintf "%a" pp_taccess_type x)

and pp_shape_kind : Format.formatter -> shape_kind -> unit =
 fun fmt sk ->
  match sk with
  | Closed_shape -> Format.pp_print_string fmt "Closed_shape"
  | Open_shape -> Format.pp_print_string fmt "Open_shape"

and show_shape_kind : shape_kind -> string =
 (fun x -> Format.asprintf "%a" pp_shape_kind x)

and pp_reactivity : Format.formatter -> reactivity -> unit =
 fun fmt r ->
  match r with
  (* Nonreactive functions are printed in error messages as "normal", *)
  (* But for this printing purpose, we print the same as the ast structure *)
  | Nonreactive -> Format.pp_print_string fmt "Nonreactive"
  | RxVar v ->
    Format.pp_print_string fmt "RxVar {";
    Option.iter v (pp_reactivity fmt);
    Format.pp_print_string fmt "}"
  | MaybeReactive v ->
    Format.pp_print_string fmt "MaybeReactive {";
    pp_reactivity fmt v;
    Format.pp_print_string fmt "}"
  | Local None -> Format.pp_print_string fmt "Local {}"
  | Local (Some ty) ->
    Format.pp_print_string fmt "Local {";
    pp_ty fmt ty;
    Format.pp_print_string fmt "}"
  | Shallow None -> Format.pp_print_string fmt "Shallow {}"
  | Shallow (Some ty) ->
    Format.pp_print_string fmt "Shallow {";
    pp_ty fmt ty;
    Format.pp_print_string fmt "}"
  | Reactive None -> Format.pp_print_string fmt "Reactive {}"
  | Reactive (Some ty) ->
    Format.pp_print_string fmt "Reactive {";
    pp_ty fmt ty;
    Format.pp_print_string fmt "}"
  | Pure None -> Format.pp_print_string fmt "Pure {}"
  | Pure (Some ty) ->
    Format.pp_print_string fmt "Pure {";
    pp_ty fmt ty;
    Format.pp_print_string fmt "}"
  | Cipp None -> Format.pp_print_string fmt "Cipp {}"
  | Cipp (Some s) ->
    Format.pp_print_string fmt "Cipp {";
    Format.pp_print_string fmt s;
    Format.pp_print_string fmt "}"
  | CippLocal None -> Format.pp_print_string fmt "CippLocal {}"
  | CippLocal (Some s) ->
    Format.pp_print_string fmt "CippLocal {";
    Format.pp_print_string fmt s;
    Format.pp_print_string fmt "}"
  | CippGlobal -> Format.pp_print_string fmt "CippGlobal"
  | CippRx -> Format.pp_print_string fmt "CippRx"

and show_reactivity : reactivity -> string =
 (fun x -> Format.asprintf "%a" pp_reactivity x)

and pp_possibly_enforced_ty :
    type a. Format.formatter -> a ty possibly_enforced_ty -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "et_enforced";
  Format.fprintf fmt "%B" x.et_enforced;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "et_type";
  pp_ty fmt x.et_type;
  Format.fprintf fmt "@]";
  Format.fprintf fmt "@ }@]"

and pp_fun_elt : Format.formatter -> fun_elt -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "fe_pos";
  Pos.pp fmt x.fe_pos;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "fe_type";
  pp_ty fmt x.fe_type;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "fe_deprecated";
  (match x.fe_deprecated with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    Format.fprintf fmt "%S" x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@ }@]"

and show_fun_elt x = Format.asprintf "%a" pp_fun_elt x

and pp_fun_implicit_params :
    type a. Format.formatter -> a ty fun_implicit_params -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "capability";
  pp_ty fmt x.capability;
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and pp_fun_type : type a. Format.formatter -> a ty fun_type -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "ft_arity";
  pp_fun_arity fmt x.ft_arity;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ft_tparams";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_tparam fmt x;
         true)
       ~init:false
       x.ft_tparams);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ft_where_constraints";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_where_constraint fmt x;
         true)
       ~init:false
       x.ft_where_constraints);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ft_params";
  pp_fun_params fmt x.ft_params;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ft_implicit_params";
  pp_fun_implicit_params fmt x.ft_implicit_params;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ft_ret";
  pp_possibly_enforced_ty fmt x.ft_ret;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  let pp_ft_flags fmt ft =
    Format.fprintf fmt "@[<2>(%s@ " "make_ft_flags";

    Format.fprintf fmt "@[";
    Format.fprintf fmt "%s" (show_fun_kind (get_ft_fun_kind ft));
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[";
    Format.fprintf
      fmt
      "%s"
      (show_param_mutability_opt (get_ft_param_mutable ft));
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "return_disposable";
    Format.fprintf fmt "%B" (get_ft_return_disposable ft);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "returns_mutable";
    Format.fprintf fmt "%B" (get_ft_returns_mutable ft);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "returns_void_to_rx";
    Format.fprintf fmt "%B" (get_ft_returns_void_to_rx ft);
    Format.fprintf fmt "@]";

    Format.fprintf fmt ")@]"
  in

  Format.fprintf fmt "@[%s =@ " "ft_flags";
  pp_ft_flags fmt x;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ft_reactive";
  pp_reactivity fmt x.ft_reactive;
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_param_mutability_opt : param_mutability option -> string =
 fun x ->
  match x with
  | None -> "none"
  | Some p -> show_param_mutability p

and show_param_mutability : param_mutability -> string =
 fun x ->
  match x with
  | Param_owned_mutable -> "owned mutable"
  | Param_borrowed_mutable -> "mutable"
  | Param_maybe_mutable -> "maybe-mutable"

and show_fun_kind : Ast_defs.fun_kind -> string =
 fun x ->
  Ast_defs.(
    match x with
    | FSync -> "sync"
    | FAsync -> "async"
    | FGenerator -> "generator"
    | FAsyncGenerator -> "async generator"
    | FCoroutine -> "coroutine")

and show_fun_type : type a. a ty fun_type -> string =
 (fun x -> Format.asprintf "%a" pp_fun_type x)

and pp_fun_arity : type a. Format.formatter -> a ty fun_arity -> unit =
 fun fmt fa ->
  match fa with
  | Fstandard ->
    Format.fprintf fmt "(@[<2>Fstandard (@,";
    Format.fprintf fmt "@,))@]"
  | Fvariadic a1 ->
    Format.fprintf fmt "(@[<2>Fvariadic (@,";
    pp_fun_param fmt a1;
    Format.fprintf fmt "@,))@]"

and show_fun_arity : type a. a ty fun_arity -> string =
 (fun x -> Format.asprintf "%a" pp_fun_arity x)

and pp_param_mode : Format.formatter -> param_mode -> unit =
 fun fmt mode ->
  match mode with
  | FPnormal -> Format.pp_print_string fmt "FPnormal"
  | FPinout -> Format.pp_print_string fmt "FPinout"

and show_param_mode : param_mode -> string =
 (fun x -> Format.asprintf "%a" pp_param_mode x)

and pp_fun_param : type a. Format.formatter -> a ty fun_param -> unit =
  let pp_fp_flags fmt fp =
    Format.fprintf fmt "@[<2>(%s@ " "make_fp_flags";

    Format.fprintf fmt "@[~%s:" "mutability";
    Format.fprintf fmt "%s" (show_param_mutability_opt (get_fp_mutability fp));
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "accept_disposable";
    Format.fprintf fmt "%B" (get_fp_accept_disposable fp);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "has_default";
    Format.fprintf fmt "%B" (get_fp_has_default fp);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "mode";
    Format.fprintf fmt "%s" (show_param_mode (get_fp_mode fp));
    Format.fprintf fmt "@]";

    Format.fprintf fmt ")@]"
  in

  fun fmt x ->
    Format.fprintf fmt "@[<2>{ ";

    Format.fprintf fmt "@[%s =@ " "fp_pos";
    Pos.pp fmt x.fp_pos;
    Format.fprintf fmt "@]";
    Format.fprintf fmt ";@ ";

    Format.fprintf fmt "@[%s =@ " "fp_name";
    (match x.fp_name with
    | None -> Format.pp_print_string fmt "None"
    | Some x ->
      Format.pp_print_string fmt "(Some ";
      Format.fprintf fmt "%S" x;
      Format.pp_print_string fmt ")");
    Format.fprintf fmt "@]";
    Format.fprintf fmt ";@ ";

    Format.fprintf fmt "@[%s =@ " "fp_type";
    pp_possibly_enforced_ty fmt x.fp_type;
    Format.fprintf fmt "@]";
    Format.fprintf fmt ";@ ";

    Format.fprintf fmt "@[%s =@ " "fp_flags";
    pp_fp_flags fmt x;
    Format.fprintf fmt "@]";
    Format.fprintf fmt ";@ ";

    Format.fprintf fmt "@ }@]"

and show_fun_param : type a. a ty fun_param -> string =
 (fun x -> Format.asprintf "%a" pp_fun_param x)

and pp_fun_params : type a. Format.formatter -> a ty fun_params -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_fun_param fmt x;
         true)
       ~init:false
       x);
  Format.fprintf fmt "@,]@]"

and show_fun_params : type a. a ty fun_params -> string =
 (fun x -> Format.asprintf "%a" pp_fun_params x)

and pp_class_elt : Format.formatter -> class_elt -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "ce_visibility";
  ( Format.pp_print_string fmt
  @@
  match x.ce_visibility with
  | Vpublic -> "Vpublic"
  | Vprivate s -> "Vprivate " ^ s
  | Vprotected s -> "Vprotected " ^ s );
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ce_type";
  if Lazy.is_val x.ce_type then
    pp_ty fmt (Lazy.force x.ce_type)
  else
    Format.pp_print_string fmt "<not evaluated>";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ce_origin";
  Format.fprintf fmt "%S" x.ce_origin;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  let pp_ce_flags fmt ce =
    Format.fprintf fmt "@[<2>(%s@ " "make_ce_flags";

    Format.fprintf fmt "@[~%s:" "abstract";
    Format.fprintf fmt "%B" (get_ce_abstract ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "final";
    Format.fprintf fmt "%B" (get_ce_final ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "override";
    Format.fprintf fmt "%B" (get_ce_override ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "lsb";
    Format.fprintf fmt "%B" (get_ce_lsb ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "memoizelsb";
    Format.fprintf fmt "%B" (get_ce_memoizelsb ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "synthesized";
    Format.fprintf fmt "%B" (get_ce_synthesized ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "const";
    Format.fprintf fmt "%B" (get_ce_const ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "lateinit";
    Format.fprintf fmt "%B" (get_ce_lateinit ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "dynamicallycallable";
    Format.fprintf fmt "%B" (get_ce_dynamicallycallable ce);
    Format.fprintf fmt "@]";
    Format.fprintf fmt "@ ";

    Format.fprintf fmt "@[~%s:" "xhp_attr";
    (match get_ce_xhp_attr ce with
    | None -> Format.pp_print_string fmt "None"
    | Some x ->
      Format.pp_print_string fmt "(Some ";
      pp_xhp_attr fmt x;
      Format.pp_print_string fmt ")");
    Format.fprintf fmt "@]";

    Format.fprintf fmt ")@]"
  in

  Format.fprintf fmt "@[%s =@ " "ce_flags";
  pp_ce_flags fmt x;
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_class_elt : class_elt -> string =
 (fun x -> Format.asprintf "%a" pp_class_elt x)

and pp_class_const : Format.formatter -> class_const -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "cc_synthesized";
  Format.fprintf fmt "%B" x.cc_synthesized;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "cc_abstract";
  Format.fprintf fmt "%B" x.cc_abstract;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "cc_pos";
  Pos.pp fmt x.cc_pos;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "cc_type";
  pp_ty fmt x.cc_type;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "cc_origin";
  Format.fprintf fmt "%S" x.cc_origin;
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_class_const : class_const -> string =
 (fun x -> Format.asprintf "%a" pp_class_const x)

and pp_const_decl : Format.formatter -> const_decl -> unit =
 fun fmt x ->
  Format.fprintf fmt "(@[";
  Pos.pp fmt x.cd_pos;
  Format.fprintf fmt ",@ ";
  pp_ty fmt x.cd_type;
  Format.fprintf fmt "@])"

and show_const_elt : const_decl -> string =
 (fun x -> Format.asprintf "%a" pp_const_decl x)

and pp_requirement : Format.formatter -> requirement -> unit =
 fun fmt (a0, a1) ->
  Format.fprintf fmt "(@[";
  Pos.pp fmt a0;
  Format.fprintf fmt ",@ ";
  pp_ty fmt a1;
  Format.fprintf fmt "@])"

and show_requirement : requirement -> string =
 (fun x -> Format.asprintf "%a" pp_requirement x)

and pp_consistent_kind : Format.formatter -> consistent_kind -> unit =
 fun fmt ck ->
  match ck with
  | Inconsistent -> Format.pp_print_string fmt "Inconsistent"
  | ConsistentConstruct -> Format.pp_print_string fmt "ConsistentConstruct"
  | FinalClass -> Format.pp_print_string fmt "FinalClass"

and pp_class_type : Format.formatter -> class_type -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "tc_need_init";
  Format.fprintf fmt "%B" x.tc_need_init;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_members_fully_known";
  Format.fprintf fmt "%B" x.tc_members_fully_known;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_abstract";
  Format.fprintf fmt "%B" x.tc_abstract;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_final";
  Format.fprintf fmt "%B" x.tc_final;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_const";
  Format.fprintf fmt "%B" x.tc_const;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_deferred_init_members";
  SSet.pp fmt x.tc_deferred_init_members;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_kind";
  Ast_defs.pp_class_kind fmt x.tc_kind;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_is_xhp";
  Format.fprintf fmt "%B" x.tc_is_xhp;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_is_disposable";
  Format.fprintf fmt "%B" x.tc_is_disposable;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_name";
  Format.fprintf fmt "%S" x.tc_name;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_pos";
  Pos.pp fmt x.tc_pos;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_tparams";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_tparam fmt x;
         true)
       ~init:false
       x.tc_tparams);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_consts";
  SMap.pp pp_class_const fmt x.tc_consts;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_typeconsts";
  SMap.pp pp_typeconst_type fmt x.tc_typeconsts;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_props";
  SMap.pp pp_class_elt fmt x.tc_props;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_sprops";
  SMap.pp pp_class_elt fmt x.tc_sprops;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_methods";
  SMap.pp pp_class_elt fmt x.tc_methods;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_smethods";
  SMap.pp pp_class_elt fmt x.tc_smethods;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_construct";
  let (a0, a1) = x.tc_construct in
  Format.fprintf fmt "(@[";
  (match a0 with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    pp_class_elt fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt ",@ ";
  pp_consistent_kind fmt a1;
  Format.fprintf fmt "@])";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_ancestors";
  SMap.pp pp_ty fmt x.tc_ancestors;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_req_ancestors";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_requirement fmt x;
         true)
       ~init:false
       x.tc_req_ancestors);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_req_ancestors_extends";
  SSet.pp fmt x.tc_req_ancestors_extends;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_extends";
  SSet.pp fmt x.tc_extends;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_enum_type";
  (match x.tc_enum_type with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    pp_enum_type fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "tc_sealed_whitelist";
  (match x.tc_sealed_whitelist with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    SSet.pp fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_class_type : class_type -> string =
 (fun x -> Format.asprintf "%a" pp_class_type x)

and pp_typeconst_abstract_kind :
    Format.formatter -> typeconst_abstract_kind -> unit =
 fun fmt x ->
  match x with
  | TCAbstract default ->
    Format.pp_print_string fmt "TCAbstract {";
    Option.iter default (pp_ty fmt);
    Format.pp_print_string fmt "}"
  | TCPartiallyAbstract -> Format.pp_print_string fmt "TCPartiallyAbstract"
  | TCConcrete -> Format.pp_print_string fmt "TCConcrete"

and pp_typeconst_type : Format.formatter -> typeconst_type -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "ttc_abstract";
  pp_typeconst_abstract_kind fmt x.ttc_abstract;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ttc_name";
  Aast.pp_sid fmt x.ttc_name;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ttc_constraint";
  (match x.ttc_constraint with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    pp_ty fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ttc_type";
  (match x.ttc_type with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    pp_ty fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ttc_origin";
  Format.fprintf fmt "%S" x.ttc_origin;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "ttc_enforceable";
  Format.pp_print_string fmt "(";
  Pos.pp fmt (fst x.ttc_enforceable);
  Format.fprintf fmt ", %B)" (snd x.ttc_enforceable);
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_typeconst_type : typeconst_type -> string =
 (fun x -> Format.asprintf "%a" pp_typeconst_type x)

and pp_pu_enum_type : Format.formatter -> pu_enum_type -> unit =
 (fun fmt _ -> Format.fprintf fmt "PUENUM PP")

and show_pu_enum_type : pu_enum_type -> string = (fun _ -> "PUENUM")

and pp_enum_type : Format.formatter -> enum_type -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "te_base";
  pp_ty fmt x.te_base;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "te_constraint";
  (match x.te_constraint with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    pp_ty fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_enum_type : enum_type -> string =
 (fun x -> Format.asprintf "%a" pp_enum_type x)

and pp_typedef_type : Format.formatter -> typedef_type -> unit =
 fun fmt x ->
  Format.fprintf fmt "@[<2>{ ";

  Format.fprintf fmt "@[%s =@ " "td_pos";
  Pos.pp fmt x.td_pos;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "td_vis";
  Aast.pp_typedef_visibility fmt x.td_vis;
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "td_tparams";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         pp_tparam fmt x;
         true)
       ~init:false
       x.td_tparams);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "td_constraint";
  (match x.td_constraint with
  | None -> Format.pp_print_string fmt "None"
  | Some x ->
    Format.pp_print_string fmt "(Some ";
    pp_ty fmt x;
    Format.pp_print_string fmt ")");
  Format.fprintf fmt "@]";
  Format.fprintf fmt ";@ ";

  Format.fprintf fmt "@[%s =@ " "td_type";
  pp_ty fmt x.td_type;
  Format.fprintf fmt "@]";

  Format.fprintf fmt "@ }@]"

and show_typedef_type : typedef_type -> string =
 (fun x -> Format.asprintf "%a" pp_typedef_type x)

and pp_tparam : type a. Format.formatter -> a ty tparam -> unit =
 fun fmt
     {
       tp_variance;
       tp_name;
       tp_tparams;
       tp_constraints;
       tp_reified;
       tp_user_attributes;
     } ->
  Format.fprintf fmt "(@[";
  Ast_defs.pp_variance fmt tp_variance;
  Format.fprintf fmt ",@ ";
  Ast_defs.pp_id fmt tp_name;

  if not (List.is_empty tp_tparams) then begin
    Format.fprintf fmt "@[<2><";
    ignore
      (List.fold_left
         ~f:(fun sep x ->
           if sep then Format.fprintf fmt ";@ ";
           pp_tparam fmt x;
           true)
         ~init:false
         tp_tparams);
    Format.fprintf fmt "@,>@]"
  end;

  Format.fprintf fmt ",@ ";
  Format.fprintf fmt "@[<2>[";
  ignore
    (List.fold_left
       ~f:(fun sep x ->
         if sep then Format.fprintf fmt ";@ ";
         let (b0, b1) = x in
         Format.fprintf fmt "(@[";
         Ast_defs.pp_constraint_kind fmt b0;
         Format.fprintf fmt ",@ ";
         pp_ty fmt b1;
         Format.fprintf fmt "@])";
         true)
       ~init:false
       tp_constraints);
  Format.fprintf fmt "@,]@]";
  Format.fprintf fmt ",@ ";
  Aast.pp_reify_kind fmt tp_reified;

  if not (List.is_empty tp_user_attributes) then begin
    Format.fprintf fmt "@[<2><";
    ignore
      (List.fold_left
         ~f:(fun sep x ->
           if sep then Format.fprintf fmt ";@ ";
           pp_user_attribute fmt x;
           true)
         ~init:false
         tp_user_attributes);
    Format.fprintf fmt "@,>@]"
  end;
  Format.fprintf fmt "@])"

and show_tparam : type a. a ty tparam -> string =
 (fun x -> Format.asprintf "%a" pp_tparam x)

and pp_where_constraint :
    type a. Format.formatter -> a ty where_constraint -> unit =
 fun fmt (a0, a1, a2) ->
  Format.fprintf fmt "(@[";
  pp_ty fmt a0;
  Format.fprintf fmt ",@ ";
  Ast_defs.pp_constraint_kind fmt a1;
  Format.fprintf fmt ",@ ";
  pp_ty fmt a2;
  Format.fprintf fmt "@])"

and show_where_constraint : type a. a ty where_constraint -> string =
 (fun x -> Format.asprintf "%a" pp_where_constraint x)

let pp_decl _ _ = ()

let pp_locl _ _ = ()

let pp_decl_phase _ _ = ()

let pp_locl_phase _ _ = ()

let pp_decl_ty fmt ty = pp_ty fmt ty

let show_decl_ty x = show_ty x

let pp_locl_ty fmt ty = pp_ty fmt ty

let show_locl_ty x = show_ty x

let pp_ty _ fmt ty = pp_ty fmt ty

let show_ty _ x = show_ty x

let pp_shape_field_type _ fmt x = pp_shape_field_type fmt x

let show_shape_field_type _ x = show_shape_field_type x

let pp_ty_ _ fmt x = pp_ty_ fmt x

let show_ty_ _ x = show_ty_ x

let pp_decl_fun_type fmt x = pp_fun_type fmt x

let pp_locl_fun_type fmt x = pp_fun_type fmt x

let pp_fun_type _ fmt x = pp_fun_type fmt x

let pp_possibly_enforced_ty _ fmt x = pp_possibly_enforced_ty fmt x

let show_fun_type _ x = show_fun_type x

let pp_fun_arity _ fmt x = pp_fun_arity fmt x

let show_fun_arity _ x = show_fun_arity x

let pp_fun_param _ fmt x = pp_fun_param fmt x

let show_fun_param _ x = show_fun_param x

let pp_fun_params _ fmt x = pp_fun_params fmt x

let show_fun_params _ x = show_fun_params x

let pp_decl_tparam fmt x = pp_tparam fmt x

let pp_tparam _ fmt x = pp_tparam fmt x

let show_tparam _ x = show_tparam x

let pp_decl_where_constraint fmt x = pp_where_constraint fmt x

let pp_where_constraint _ fmt x = pp_where_constraint fmt x

let show_where_constraint _ x = show_where_constraint x
